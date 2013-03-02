class UsersController < ApplicationController
  before_filter :find_user, only: [:show, :edit, :update]

  def index
    @users = User.find(:all)
  end

  def show
  end

  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    
    @user = User.new(params[:user])
    @user.ip = request.remote_ip
    if @user.save
      sign_in @user
      redirect_to @user
    else
      redirect_to signup_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  def delete
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
