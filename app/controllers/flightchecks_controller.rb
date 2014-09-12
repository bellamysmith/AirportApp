class FlightchecksController < ApplicationController
	def index 
		@flightNum = 
		url = "https://api.flightstats.com/flex/schedules/rest/v1/json/flight/" + @airline + "/" + @flight_num + "/departing/" + Date.today.year.to_s + "/" + Date.today.month.to_s + "/" + Date.today.day.to_s + "?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384"
		response = HTTParty.get(url)
		@info = response.body
		body = JSON.parse(@info)
		@id = body["scheduledFlights"][0]["flightNumber"]
	end

	def create
		@flight_num = 
	end




end
