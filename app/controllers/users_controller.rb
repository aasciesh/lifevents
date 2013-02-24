class UsersController < ApplicationController

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(params[:user])
    if @user.save
      sign_in @user
      #flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  def delete

  end
end
