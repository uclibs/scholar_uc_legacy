# helper for the WorksControllerBehavior class
# cleaner to keep all change manager code in here
module ChangeManager
  module ChangeManagerHelper

    def queue_notifications_for_editors(editors)

      editors.each do |editor_wrapper|
        editor = editor_wrapper[1]
        if is_new_editor? editor
          EmailManager.queue_change(curation_concern.depositor, 'added_as_editor', curation_concern.id, editor[:name])
        # uncomment this once the `Ldp::Gone` error is resolved
        elsif is_removed_editor? editor
          EmailManager.queue_change(curation_concern.depositor, 'removed_as_editor', curation_concern.id, editor[:name])
        end
      end
    rescue NotImplementedError
      editors.each do |editor_wrapper|
        editor = editor_wrapper[1]
        if is_new_editor? editor
          EmailManager.skip_sidekiq_for_emails(curation_concern.depositor, 'added_as_editor', curation_concern.id, editor[:name])
        # uncomment this once the `Ldp::Gone` error is resolved
        elsif is_removed_editor? editor
          EmailManager.skip_sidekiq_for_emails(curation_concern.depositor, 'removed_as_editor', curation_concern.id, editor[:name])
        end
      end
    end

    private
    def is_new_editor?(editor)
      has_edit_access?(editor) && has_name_key?(editor)
    end

    def is_removed_editor?(editor)
      #implement once Ldp::Gone error is resolved
      false
    end

    def has_name_key?(hash)
      hash.key? 'name'
    end

    def has_edit_access?(hash)
      hash.key?('access') && hash[:access] == 'edit'
    end

  end
end
