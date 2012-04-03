class HomeController < ApplicationController
  
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
