class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :signin_first
  
  def signin_first
    render '/sessions/new' unless signed_in?
  end
end
