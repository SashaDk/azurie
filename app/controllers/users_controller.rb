class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :fakereg]
  load_and_authorize_resource
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # POST /users/fakereg
  def fakereg
    UserMailer.fakereg(params).deliver
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/1/make_expert
  def make_expert
    @user = User.find(params[:id])
    @user.make_expert!
    
    redirect_to users_path, :notice => 'User was successfully promoted to experts.'
  end
  
  # GET /users/1/make_admin
  def make_admin
    @user = User.find(params[:id])
    @user.make_admin!
    
    redirect_to users_path, :notice => 'User was successfully promoted to admins.'
  end
  
  # GET /users/1/make_guest
  def make_guest
    @user = User.find(params[:id])
    @user.make_guest!
    
    redirect_to users_path, :notice => 'User was successfully made guest.'
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
