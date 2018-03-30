# frozen_string_literal: true
module Hyrax
  class CustomStatImporter
    attr_reader :start_date, :object
    def initialize(object, options)
      if options[:verbose]
        stdout_logger = Logger.new(STDOUT)
        stdout_logger.level = Logger::INFO
        Rails.logger.extend(ActiveSupport::Logger.broadcast(stdout_logger))
      end
      @logging = options[:logging]
      @delay_secs = options[:delay_secs].to_f
      @number_of_retries = options[:number_of_retries].to_i
      @object = object
      @start_date = if object.stats_last_gathered.nil?
                      Hyrax.config.analytic_start_date
                    else
                      object.stats_last_gathered
                    end
    end

    def import
      stats = {}
      user = ::User.find_by_email(object.user_email)

      case object.object_type
      when "work"
        work = Hyrax::WorkRelation.new.find(object.object_id)

        work_stats = rescue_and_retry("Retried WorkViewStat on #{user} for work #{work.id} too many times.") { WorkViewStat.statistics(work, start_date, user.id) }
        stats = tally_results(work_stats, :work_views, stats) if work_stats.present?
        delay
      when "file"
        file = ::FileSet.find(object.object_id)

        view_stats = rescue_and_retry("Retried FileViewStat on #{user} for file #{file.id} too many times.") { FileViewStat.statistics(file, start_date, user.id) }
        stats = tally_results(view_stats, :views, stats) if view_stats.present?
        delay

        dl_stats = rescue_and_retry("Retried FileDownloadStat on #{user} for file #{file.id} too many times.") { FileDownloadStat.statistics(file, start_date, user.id) }
        stats = tally_results(dl_stats, :downloads, stats) if dl_stats.present?
        delay
      end

      create_or_update_user_stats(stats, user)
      object.update_stats_last_gathered
    end

    private

      def delay
        sleep @delay_secs
      end

      def rescue_and_retry(fail_message)
        retry_count = 0
        begin
          return yield
        rescue StandardError => e
          retry_count += 1
          if retry_count < @number_of_retries
            delay
            retry
          else
            log_message fail_message
            log_message "Last exception #{e}"
          end
        end
      end

      def tally_results(current_stats, stat_name, total_stats)
        current_stats.each do |stats|
          # Exclude the stats from today since it will only be a partial day's worth of data
          break if stats.date == Time.zone.today

          date_key = stats.date.to_s
          old_count = total_stats[date_key] ? total_stats[date_key].fetch(stat_name) { 0 } : 0
          new_count = old_count + stats.method(stat_name).call

          old_values = total_stats[date_key] || {}
          total_stats.store(date_key, old_values)
          total_stats[date_key].store(stat_name, new_count)
        end
        total_stats
      end

      def create_or_update_user_stats(stats, user)
        stats.each do |date_string, data|
          date = Time.zone.parse(date_string)

          user_stat = UserStat.where(user_id: user.id, date: date).first_or_initialize(user_id: user.id, date: date)

          user_stat.file_views = data.fetch(:views, 0)
          user_stat.file_downloads = data.fetch(:downloads, 0)
          user_stat.work_views = data.fetch(:work_views, 0)
          user_stat.save!
        end
      end

      def log_message(message)
        Rails.logger.info "#{self.class}: #{message}" if @logging
      end
  end
end
