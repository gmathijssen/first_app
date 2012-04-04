class HomeController < ApplicationController
  before_filter :signin_first
  
  def signin_first
    
  end
  
  def index
    @title = "Home"
  end

  def admin
    if current_user_is_admin?
      @title = "Admin"
    else
      render "errors/access_denied"
    end
  end

end
