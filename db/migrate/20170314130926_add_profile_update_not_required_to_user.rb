class AddProfileUpdateNotRequiredToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_update_not_required, :boolean
  end
end
