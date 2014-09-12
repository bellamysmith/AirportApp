class ReviewsController < ApplicationController
	def index
		@review = Review.all
	end
	def new
		@review = Review.new
	end
	def show
		@review = Review.find(params[:id])
	end
	def create
		@user = current_user
		@review = @user.reviews.new(params.require(:review).permit(:overall_score, :parking, :review_notes, :date_time, :user_id, :airport_id, :food_and_drink))
		if @review.save
			redirect_to reviews_path
		else
			render 'new'
		end
	end
end
