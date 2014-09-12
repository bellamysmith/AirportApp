require 'httparty'

class AirportsController < ApplicationController
	include HTTParty
	def index
		@airports = Airport.all
		response = HTTParty.get("https://api.flightstats.com/flex/schedules/rest/v1/json/flight/AA/2583/departing/2014/09/10?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384")
		@info = response.body
		body = JSON.parse(@info)
		@id = body["scheduledFlights"][0]["flightNumber"]
	
	
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
		@airport = Airport.new(params.require(:airport).permit(:name, :city, :state))
		if @airport.save
			redirect_to airports_path
		else
			render 'new'
		end
	end

# Use the class methods to get down to business quickly
end

