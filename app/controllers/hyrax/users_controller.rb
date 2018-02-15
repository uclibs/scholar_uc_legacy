# frozen_string_literal: true
module Hyrax
  class UsersController < ApplicationController
    include Blacklight::SearchContext

    def show
      @presenter = Hyrax::UserProfilePresenter.new(@user, current_ability)
      @permalinks_presenter = PermalinksPresenter.new(hyrax.dashboard_profile_path(locale: nil))
    end

    def search(query)
      clause = query.blank? ? nil : "%" + query.downcase + "%"
      base = ::User.where(*base_query)
      unless clause.blank?
        base = base.where("#{Devise.authentication_keys.first} like lower(?)
                             OR display_name like lower(?)
                             OR first_name like lower(?)
                             OR last_name like lower(?)", clause, clause, clause, clause)
      end
      base.where("#{Devise.authentication_keys.first} not in (?)",
                 [::User.batch_user_key, ::User.audit_user_key])
          .where(guest: false)
          .references(:trophies)
          .order(sort_value)
          .page(params[:page]).per(10)
    end

    protected

      def user_work_count(user)
        Hyrax::WorkRelation.new.where(DepositSearchBuilder.depositor_field => user.user_key).count
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :avatar, :facebook_handle, :twitter_handle, :title,
                                     :googleplus_handle, :linkedin_handle, :remove_avatar, :orcid, :ucdepartment,
                                     :blog, :alternate_phone_number, :alternate_email, :uc_affiliation, :website, :telephone)
      end
  end
end
