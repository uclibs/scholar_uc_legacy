class AddWaivedWelcomeToUser < ActiveRecord::Migration
  def change
    add_column :users, :waived_welcome_page, :boolean
  end
end
