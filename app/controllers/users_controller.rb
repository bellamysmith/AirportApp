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
	def edit
		@user = User.find(params[:id])
	end
	def create
  	@user = User.new(params.require(:user).permit(:name, :email, :password))
  	if @user.save
  		redirect_to root_path
  	else
  		render 'new'
  	end

  end

  def review_list
  	@user = current_user
  end

  def destroy
  
  	@user = User.find(params[:id])
  	log_out
  	@user.destroy
  	redirect_to airports_path


  end
end
