# frozen_string_literal: true
class User < ActiveRecord::Base
  # Connects this user object to Hydra behaviors.
  include Hydra::User
  # Connects this user object to Role-management behaviors.
  include Hydra::RoleManagement::UserRoles

  # Connects this user object to Curation Concerns behaviors.
  include CurationConcerns::User
  # Connects this user object to Sufia behaviors.
  include Sufia::User
  include Sufia::UserUsageStats

  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  end
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:orcid]

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end

  def name_for_works
    last_name + ", " + first_name unless first_name.blank? || last_name.blank?
  end

  def name
    return "#{first_name} #{last_name}" unless first_name.blank? || last_name.blank?
    user_key
  end

  def display_name
    name
  end

  def waive_welcome_page!
    update_column(:waived_welcome_page, true)
  end

  def student?
    uc_affiliation == 'student'
  end
end
