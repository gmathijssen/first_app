class PagesController < ApplicationController
  before_filter :signin_first
  
  def signin_first
    
  end
  
  def home
      @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def info
    @title = "Info"
  end

end
