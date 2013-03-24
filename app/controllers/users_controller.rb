class UsersController < ApplicationController
  before_filter :find_user, only: [:show, :edit, :update]
  before_filter :signed_in_user, only: [:edit, :update, :delete]
  before_filter :confirm_right_user, only: [:edit, :update, :delete]

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
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
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

  def confirm_right_user
    unless User.find(params[:id]) == current_user 
      redirect_to root_path
    end
  end
end
