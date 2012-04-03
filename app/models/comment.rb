class Comment < ActiveRecord::Base
  include SessionsHelper
  
  belongs_to :post, :foreign_key => :post_id
  belongs_to :user, :foreign_key => :user_id
  
  # before_save :default_values
  
  def default_values
    u = current_user
    puts u
    self.user_id ||= u
  end
end
