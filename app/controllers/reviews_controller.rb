class ReviewsController < ApplicationController
	def index
		@airports = []
		@airport = Airport.all.each do |a|
			if a.score.to_i > 5
				@airports.push([a.name, a.score])
			end
				@airports.sort_by {|a, v| a = v}
			end
		
	end
	def new

		if !logged_in?
			redirect_to sign_in_path
		end
		@review = Review.new
	end
	def show
		@review = Review.find(params[:id])
	end
	def create
		@user = current_user
		@review = @user.reviews.new(params.require(:review).permit(:overall_score, :parking, :review_notes, :user_id, :airport_id, :food_and_drink, :international, :terminal, :tip, :good_for_layovers, :shopping, :free_wifi, :wifi))
		if @review.save
			redirect_to review_path(@review)
		else
			render 'new'
		end
	end

	def search
		@airport = Airport.find_by(params[:airport][:code])
		render 'show'
	end
end
