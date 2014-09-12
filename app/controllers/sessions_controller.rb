class SessionsController < ApplicationController
	def new
		flash.clear
	end

	def create
		flash.clear
		begin
			user = User.find_by({email: params[:session][:email]})
		rescue
			flash[:error] = 'Email not found.'
		end

		if user && user.authenticate(params[:session][:password])
			flash[:success] = 'Logged In!'
			log_in(user)
			redirect_to root_path
		else
			flash[:error] ||= 'Password not found.'
			render 'new'
		end

		
	end

	def destroy
		log_out
		redirect_to sessions_path
	end
end
