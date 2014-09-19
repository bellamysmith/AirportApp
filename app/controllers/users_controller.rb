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
  def update
    @user = current_user
    if @user.update_attributes(params.require(:user).permit(:name, :email))
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  def destroy
  
  	@user = User.find(params[:id])
  	log_out
  	@user.destroy
  	redirect_to airports_path


  end
end
