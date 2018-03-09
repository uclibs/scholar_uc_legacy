# frozen_string_literal: true
namespace :scholar do
  desc 'Loop over all objects and regenerative derivatives'
  task regenerate_derivatives: [:environment] do
    Document.all.map(&:members).each do |members|
      next if members.blank?
      members.each do |member|
        next unless member.is_a?(FileSet)
        if member.original_file.nil?
          Rails.logger.warn("No :original_file relation returned for FileSet (#{member.id})")
          next
        end

        if member.original_file.mime_type == "application/pdf"
          Rails.logger.debug("Regenerating derivatives for FileSet #{member.id} in the background")
          CharacterizeJob.perform_later(member, member.original_file.id)
        end
      end
    end
  end
end
