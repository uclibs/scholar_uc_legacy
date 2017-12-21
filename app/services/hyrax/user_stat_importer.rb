# frozen_string_literal: true
require Hyrax::Engine.root.join('app/services/hyrax/user_stat_importer.rb')
module Hyrax
  class UserStatImporter
    private

      def process_files(stats, user, start_date)
        file_ids_for_user(user).each do |file_id|
          file = ::FileSet.find(file_id)
          view_stats = rescue_and_retry("Retried FileViewStat on #{user} for file #{file_id} too many times.") { FileViewStat.statistics(file, start_date, user.id) }
          stats = tally_results(view_stats, :views, stats) unless (view_stats.blank? || view_stats)
          delay
          dl_stats = rescue_and_retry("Retried FileDownloadStat on #{user} for file #{file_id} too many times.") { FileDownloadStat.statistics(file, start_date, user.id) }
          stats = tally_results(dl_stats, :downloads, stats) unless (dl_stats.blank? || dl_stats)
          delay
        end
      end

      def process_works(stats, user, start_date)
        work_ids_for_user(user).each do |work_id|
          work = Hyrax::WorkRelation.new.find(work_id)
          work_stats = rescue_and_retry("Retried WorkViewStat on #{user} for work #{work_id} too many times.") { WorkViewStat.statistics(work, start_date, user.id) }
          stats = tally_results(work_stats, :work_views, stats) unless (work_stats.blank? || work_stats)
          delay
        end
      end
  end
end
