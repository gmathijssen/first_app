class AddUserToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    execute "delete from comments"
    remove_column :comments, :commenter
  end
end
