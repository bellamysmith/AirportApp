class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def show
		@user = current_user
	end
	def new
		@user = User.new
	end
	def create
  	@user = User.new(params.require(:user).permit(:name, :email, :password))
  	if @user.save
  		redirect_to root_path
  	else
  		render 'new'
  	end

  	def review_list
  		@user = current_user
  	end
  end

end
