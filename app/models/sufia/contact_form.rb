# frozen_string_literal: true
module Sufia
  class ContactForm
    include ActiveModel::Model

    attr_accessor :contact_method, :name, :email, :subject, :message
    validates :email, :name, :subject, :message, presence: true
    validates :email, format: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, allow_blank: true

    # - can't use this without ActiveRecord::Base validates_inclusion_of :category, in: ISSUE_TYPES

    # They should not have filled out the `contact_method' field. That's there to prevent spam.
    def spam?
      contact_method.present?
    end

    # Declare the e-mail headers. It accepts anything the mail method
    # in ActionMailer accepts.
    def headers
      {
        subject: "#{Sufia.config.subject_prefix} #{subject}",
        to: Sufia.config.contact_email,
        from: email
      }
    end
  end
end
