class BeanController < ApplicationController
	def index 
		@beans = Bean.all
	end
	def new
		@bean = Bean.new
	end
	def show
		@bean = Bean.find(params[:id])
	end
	def create
		@bean = Bean.new(params.require(:bean).permit(:name, :origin, :overall_review, :roast))
		if @bean.save
			redirect_to beans_path
		else
			render 'new'
		end
	end	
end
