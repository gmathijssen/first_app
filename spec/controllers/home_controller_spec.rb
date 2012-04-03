require 'spec_helper'

describe HomeController do
  render_views
  
  describe "GET 'admin'" do
    before(:each) do
      @user = Factory(:user)
      @admin = Factory(:admin)
    end
    
    it "returns http success for admins" do
      test_sign_in(@admin)
      get 'admin'
      response.should be_success
    end
    
    it "returns access denied page for non admins" do
      test_sign_in(@user)
      get 'admin'
      response.should have_selector("h1", :content => "Access Denied")
    end
  end    
end