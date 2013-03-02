module SessionsHelper

	def sign_in(user)
		cookies[:remember_cookie]=user.remember_cookie
		current_user= user
	end

	def current_user=(user)
	 @current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_cookie(cookies[:remember_cookie])
	end
	

	def signed_in?
	    !current_user.nil?
	  end

	def current_user? (user)
		user == current_user
	end
	def sign_out 
		cookies.delete :remember_cookie
		current_user = nil
	end

	def store_request_path
	    session[:return_to] = request.fullpath
	end

	def redirect_back_or(default)
	    redirect_to(session[:return_to] || default)
	    session.delete(:return_to)
	end
end