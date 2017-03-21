class AddUcdepartmentToUser < ActiveRecord::Migration
  def change
    add_column :users, :ucdepartment, :string
  end
end
