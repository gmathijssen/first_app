class HomeController < ApplicationController
  before_filter :signin_first
  
  def signin_first
    
  end
  
  def index
    @title = "Home"
    @username = (signed_in?) ? current_user.name : "Visitor"
    @posts = Post.paginate(:page => params[:page], :per_page => 5)
  end

  def admin
    if current_user_is_admin?
      @title = "Admin"
    else
      render "errors/access_denied"
    end
  end

end
