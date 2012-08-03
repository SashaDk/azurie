class Api::UsersController < ApplicationController
  before_filter :authenticate_user!

  def hello_world
    render :json => current_user
  end
end
