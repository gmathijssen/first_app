class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
  before_filter :only_for_admins, :only => [:index, :destroy]
  before_filter :authorise_as_owner, :only => [:edit, :update, :delete]
  before_filter :signin_first, :except => [:new, :create]
  
  def signin_first
    
  end
  
  def only_for_admins
    render 'errors/access_denied' unless current_user_is_admin?
  end
  
  
  def index    
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @title = @user.name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @title = "Sign up"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
  private
    def authorise_as_owner
      unless @user == current_user || current_user_is_admin?
        #You don't belong here. Go away.
        flash[:alert]  = "Mind your own business"
        redirect_to root_url, :status => 401
      end

    end
end
