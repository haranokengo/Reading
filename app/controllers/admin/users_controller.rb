class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_admin!
  def index
    @users = User.all
  end
end
