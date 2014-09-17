class ReviewsController < ApplicationController
	def index
		@airports = Airport.all
		def score
			@airports.each do |a|
				@overall = []
				@airport.reviews.each do |r|
					@overall.push(r.overall_score)
				end
			
			a.score = @overall.reduce(:+) / @overall.length

			end

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
