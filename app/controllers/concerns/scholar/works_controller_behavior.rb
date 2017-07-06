# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work GenericWork`

module Scholar
  module WorksControllerBehavior
    include ChangeManager::ChangeManagerHelper

    def new
      super
      curation_concern.read_groups = ["public"]
    end

    def create
      super
      # the to_s_u method must be implemented for every model
      editors = params[curation_concern.class.to_s_u][:permissions_attributes]
      queue_notifications_for_editors(editors) if editors
    rescue ActiveFedora::RecordInvalid # virus detected
      remove_infected_file_sets
      report_virus_found
      redirect_to main_app.polymorphic_path(curation_concern)
    end

    def update
      super
      # the to_s_u method must be implemented for every model
      editors = params[curation_concern.class.to_s_u][:permissions_attributes]
      queue_notifications_for_editors(editors) if editors
    rescue ActiveFedora::RecordInvalid # virus detected
      remove_infected_file_sets
      report_virus_found
      redirect_to main_app.polymorphic_path(curation_concern)
    end

    def show
      super
      permalink_message = "Permanent link to this page"
      @permalinks_presenter = PermalinksPresenter.new(main_app.common_object_path(locale: nil), permalink_message)
    end

    private

      def remove_infected_file_sets
        curation_concern.reload
        curation_concern.file_sets.each do |file_set|
          file_set.destroy if file_set.files.blank?
        end
      end

      def report_virus_found
        logger.warn "File discarded from work #{curation_concern.id} because a virus was detected"
        flash[:error] = "A virus was detected in a file you uploaded. "\
                        "No new files were attached to your work. "\
                        "Please review your files and re-attach."
      end
  end
end
