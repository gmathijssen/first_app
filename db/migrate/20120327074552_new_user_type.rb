class NewUserType < ActiveRecord::Migration
  def up
    add_column :users, :user_type, :integer
    remove_column :users, :type
  end

  def down
    remove_column :users, :user_type, :integer
    add_column :users, :type
  end
end
