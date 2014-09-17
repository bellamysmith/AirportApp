require 'httparty'

class AirportsController < ApplicationController
	include HTTParty

	def index
		@airports = Airport.all.sort_by{ |air| air.reviews.length}.reverse.values_at(0,1,2,3,4)
		
		if params[:search]
  			@searches = Airport.search(params[:search])
  			redirect_to airport_path(@searches)
  		end
	
		
	end
	def new
		@airport = Airport.new
	end
	def show
		@airport = Airport.find(params[:id])

		@overall = []

		@airport.reviews.each do |r|
			@overall.push(r.overall_score)
		end
	
	end
	def create

		url = "https://api.flightstats.com/flex/airports/rest/v1/json/"+params[:airport][:code]+"/today?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384"
		response = HTTParty.get(url)
		@response_code = response.code
		@info = response.body
		body = JSON.parse(@info)
		if @response_code == 200
			@airport = Airport.create({
				name: body["airport"]["name"],
				code: body["airport"]["fs"],
				city: body["airport"]["city"],
				state: body["airport"]["stateCode"],
				latitude: body["airport"]["latitude"],
				longitude: body["airport"]["longitude"],
				street: body["airport"]["street1"],
				country: body["airport"]["countryCode"],
				postalCode: body["airport"]["postalCode"]
				})
		
		end

		#@airport = Airport.new(params.require(:airport).permit(:name, :code, :city, :state))
		


		if @airport.save
			redirect_to airport_path(@airport)
		else
			render 'new'
		end
	end

# Use the class methods to get down to business quickly
end

