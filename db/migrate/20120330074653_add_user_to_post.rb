class AddUserToPost < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    execute 'UPDATE posts SET user_id = (SELECT id FROM users u WHERE u.name = posts.name)'
  end
end
