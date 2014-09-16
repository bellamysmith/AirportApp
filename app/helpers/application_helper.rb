module ApplicationHelper
def search	
	if params[:search]
  			@searches = Airport.search(params[:search])
  			redirect_to airport_path(@searches)
  		end
 end
end
