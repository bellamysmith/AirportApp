class Airport
  include Mongoid::Document
  field :name, type: String
  field :city, type: String
  field :state, type: String
  has_many :reviews

  	def sum
      inject(0.0) { |result, el| result + el }
    end

   	def avg 
   	  sum / size
	  end
end
