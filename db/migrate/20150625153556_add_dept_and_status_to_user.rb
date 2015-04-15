class AddDeptAndStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :ucstatus, :string
    add_column :users, :ucdepartment, :string
  end
end
