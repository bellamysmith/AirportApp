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
		#binding.pry
		if @response_code == 200 && body["scheduledFlights"][0]
			
			@departure_airport = body["scheduledFlights"][0]["departureAirportFsCode"]
			@arrivalAiportFSCode = body["scheduledFlights"][0]["arrivalAirportFsCode"]
			@stops = body["scheduledFlights"][0]["stops"]
			@departureTerminal = body["scheduledFlights"][0]["departureTerminal"]

			if Airport.find_by(code: @departure_airport).exists?
				@airport= Airport.find_by(code: @departure_airport)[1]
			else
				url = "https://api.flightstats.com/flex/airports/rest/v1/json/"+@departure_airport+"/today?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384"
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

		
		end
			
				
		end	
		if @airport
			@overall = []

			@airport.reviews.each do |r|
				@overall.push(r.overall_score)
			end
		end
	end







end
