class RemoveTermsOfServiceFromUserAddWaiveWelcomeToUser < ActiveRecord::Migration
  def change
    remove_column User.table_name, :agreed_to_terms_of_service
    add_column User.table_name, :waived_welcome_page, :boolean
  end
end
