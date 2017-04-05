module ChangeManager
  class EmailManager
    extend ChangeManager::Manager

    def self.queue_change(owner, change_type, context, target)
      change_id = Change.new_change(owner, change_type, context, target)
      ChangeManager::ProcessChangeJob.set(wait: 15.minutes).perform_later(change_id)
    end

    def self.skip_sidekiq_for_emails(owner, change_type, context, target)
      change_id = Change.new_change(owner, change_type, context, target)
      process_change change_id
    end

    def self.process_change(change_id)
      change = Change.find change_id
      unless change.cancelled?
        verified_changes = process_changes_similar_to change
        notify_target_of verified_changes unless verified_changes.empty?
        true
      end
    end

    def self.notify_target_of(changes)
      grouped_changes = group_changes(changes)
      if grouped_changes['proxies']
        if ChangeManager::ScholarNotificationMailer.notify_changes(grouped_changes['proxies']).deliver
          grouped_changes['proxies'].each { |change| change.notify }
        end
      end

      if grouped_changes['editors']
        if ChangeManager::ScholarNotificationMailer.notify_changes(grouped_changes['editors']).deliver
          grouped_changes['editors'].each { |change| change.notify }
        end
      end
    end

    def self.group_changes(changes)
      proxy_changes = Array.new
      editor_changes = Array.new
      changes.each do |change|
        if change.is_proxy_change?
          proxy_changes << change
        elsif change.is_editor_change?
          editor_changes << change
        end
      end

      grouped_changes = Hash.new
      grouped_changes['proxies'] = proxy_changes if !proxy_changes.empty?
      grouped_changes['editors'] = editor_changes if !editor_changes.empty?
      grouped_changes
    end
  end
end
