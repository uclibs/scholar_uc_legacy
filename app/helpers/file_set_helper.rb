# frozen_string_literal: true
module FileSetHelper
  def present_terms(presenter, terms = :all, &block)
    terms = presenter.terms if terms == :all
    Sufia::PresenterRenderer.new(presenter, self).fields(terms, &block)
  end

  def show_request_file_button(file, text)
    link_to "#{sufia.contact_path}?#{subject_and_message}#{main_app.root_url}#{main_app.download_path(file)}",
            target: :_blank,
            data: { turbolinks: false },
            class: "btn btn-default" do
              text
            end
  end

  def show_request_file_action(file, text)
    link_to text,
            "#{sufia.contact_path}?#{subject_and_message}#{main_app.root_url}#{main_app.download_path(file)}",
            title: "Download #{file.to_s.inspect}"
  end

  def subject_and_message
    URI.encode("subject=Scholar@UC file request&message=Please contact me about obtaining a copy of the file at ")
  end

  def file_is_too_large_to_download(file)
    max_file_size = 3_221_225_472 # 3 GB
    file.respond_to?(:solr_document) && file.solr_document._source[:file_size_is].to_i > max_file_size
  end
end
