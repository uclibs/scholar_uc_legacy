# frozen_string_literal: true
class Ability
  include Hydra::Ability

  include CurationConcerns::Ability
  include Sufia::Ability

  self.ability_logic += [:everyone_can_create_curation_concerns]

  # Define any customized permissions here.
  def custom_permissions
    # Limits deleting objects to a the admin user
    #
    # if current_user.admin?
    #   can [:destroy], ActiveFedora::Base
    # end

    # Limits creating new objects to a specific group
    #
    # if user_groups.include? 'special_group'
    #   can [:create], ActiveFedora::Base
    # end

    cannot [:edit, :update, :delete], Etd
    can [:manage], Etd if user_is_etd_manager || user_is_proxy_of_etd_manager

    if current_user.admin?
      can [:create, :show, :add_user, :remove_user, :index, :edit, :update, :destroy], Role
      can [:manage], Etd
      can [:create, :destroy, :update], FeaturedCollection
    end
  end

  private

    # remove create ability for Etd's from all users
    def curation_concerns_models
      default_curation_concerns = Sufia.config.curation_concerns
      default_curation_concerns.delete(Etd)
      [::FileSet, ::Collection] + default_curation_concerns
    end

    def user_is_etd_manager
      user_groups.include? 'etd_manager'
    end

    def user_is_proxy_of_etd_manager
      return false if current_user.can_make_deposits_for.empty?
      current_user.can_make_deposits_for.each do |grantor|
        if grantor.groups.include? 'etd_manager'
          return true
        else
          return false
        end
      end
    end
end
