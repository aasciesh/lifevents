class SessionsController < ApplicationController
  def new
  end

  def create
  	user= User.find_by_email(params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
      respond_to do |format|
        format.js {
          sign_in user
          render json: {message: 'successful'}
        }
        format.html {
          sign_in user
          redirect_back_or root_path}
        end
      else
        respond_to do |format|
          format.js {render json: {message: 'Incorrect credentials'}}
          format.html {render 'new'}
        end
      end
    end

    def destroy
     sign_out
     redirect_to root_path
   end
 end
