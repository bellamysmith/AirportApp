require 'httparty'
class FlightsController < ApplicationController

	def index 	
		if !logged_in?
			redirect_to sign_in_path
		end
	end

	def new
		if !logged_in?
			redirect_to sign_in_path
		end
		
	end

	def create
		#Creating the url variables on a POST
		@flight_num = params[:flight][:flight_num]
		@airline = params[:flight][:airline]
		@day = params[:flight][:day]
		@month = params[:flight][:month]
		@year = params[:flight][:year]
		#Grabbing the API
		url = "https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/" +@airline +"/"+@flight_num+"/dep/"+Date.today.year.to_s+"/"+Date.today.month.to_s+"/" + Date.today.day.to_s + "?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384&utc=false"
		#url = "https://api.flightstats.com/flex/schedules/rest/v1/json/flight/" + @airline + "/" + @flight_num + "/departing/" + Date.today.year.to_s + "/" + Date.today.month.to_s + "/" + Date.today.day.to_s + "?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384"
		response = HTTParty.get(url)
		@response_code = response.code
		@info = response.body
		body = JSON.parse(@info)
		
		if @response_code == 200 
		
			@departure_airport = body["flightStatuses"][0]["departureAirportFsCode"]
			@arrivalAirportFSCode = body["flightStatuses"][0]["arrivalAirportFsCode"]
			#@stops = body["flightStatuses"][0]["stops"]
			@departureTerminal = body["flightStatuses"][0]["airportResources"]["departureTerminal"]
			@departureGate = body["flightStatuses"][0]["airportResources"]["departureGate"]
			@estimatedDeparture = body["flightStatuses"][0]["operationalTimes"]["estimatedRunwayDeparture"]["dateLocal"].to_datetime
			@estimatedArrival = body["flightStatuses"][0]["operationalTimes"]["estimatedRunwayArrival"]["dateLocal"].to_datetime
			@status = body["flightStatuses"][0]["status"]
			@airport = Airport.where(code: @departure_airport).exists?
			@arrivalAirport = Airport.where(code:  @arrivalAirportFSCode).exists?
			
			if @airport == false
			
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
					@airport.save
				end
			else
				@airport = Airport.find_by(code: @departure_airport)

			end
			
			if @arrivalAirport == false
				url = "https://api.flightstats.com/flex/airports/rest/v1/json/"+@arrivalAiportFSCode+"/today?appId=324bdb96&appKey=8f9653ee6ff13e561ba83594ba49f384"
				response = HTTParty.get(url)
				@response_code = response.code
				@info = response.body
				body = JSON.parse(@info)
				
				if @response_code == 200

					@arrivalAirport = Airport.create({
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
			else
				@arrivalAirport = Airport.find_by(code: @arrivalAirportFSCode)
				
			end
		else
			@airport = nil
			@arrivalAirport	= nil
		end	
	


	end







end
