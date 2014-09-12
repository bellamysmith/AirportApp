module SessionsHelper

	#getting/retrieving a user from mongoDB
	def current_user=(user)
		@current_user = user
	end
	#getter for the User object
	def current_user
		@current_user || User.find(cookies[:remember_token])
	end

	#log in/log-out 

	def log_in(user)
		#session[:userid] = user.id
		cookies[:remember_token] = user.id
		self.current_user = user

	end

	def log_out
		#session[:userid] = nil
		cookies.delete(:remember_token) 
	end

	def logged_in?
		cookies[:remember_token] ? true : false
		
		
	end


end
