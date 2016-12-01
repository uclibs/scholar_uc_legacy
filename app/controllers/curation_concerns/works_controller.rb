# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Work`

module CurationConcerns
  class WorksController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Work

    # set default work visibility to public
    def new
      super
      curation_concern.read_groups = ["public"]
    end

    def create
      super
    rescue ActiveFedora::RecordInvalid # virus detected
      remove_infected_file_sets
      report_virus_found
      redirect_to main_app.curation_concerns_work_path(id: curation_concern.id)
    end

    def update
      super
    rescue ActiveFedora::RecordInvalid # virus detected
      remove_infected_file_sets
      report_virus_found
      redirect_to main_app.curation_concerns_work_path(id: curation_concern.id)
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
