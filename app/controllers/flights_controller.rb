class FlightsController < ApplicationController

	def index 
		
		

		

	end

	def new
		
	end

	def create
		#Creating the url variables on a POST
		@flight_num = params[:flight][:flight_num]
		@airline = params[:flight][:airline]
		#Grabbing the API

		url = "https://api.flightstats.com/flex/schedules/rest/v1/json/flight/" + @airline + "/" + @flight_num + "/departing/" + Date.today.year.to_s + "/" + Date.today.month.to_s + "/" + Date.today.day.to_s + "?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384"
		response = HTTParty.get(url)
		@response_code = response.code
		@info = response.body
		body = JSON.parse(@info)
		if @response_code == 200
			
			@departure_airport = body["scheduledFlights"][0]["departureAirportFsCode"]
			@arrivalAiportFSCode = body["scheduledFlights"][0]["arrivalAirportFsCode"]
			@stops = body["scheduledFlights"][0]["stops"]
			@departureTerminal = body["scheduledFlights"][0]["departureTerminal"]


			@airport = Airport.find_or_create_by(name: @departure_airport)
		end	
	end







end
