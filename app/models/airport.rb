class Airport
  include Mongoid::Document
  field :code, type: String
  field :name, type: String
  field :city, type: String
  field :state, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :street, type: String
  field :country, type: String
  field :postalCode, type: String
  field :score, type: Integer
  has_many :reviews

  def self.search(search)
    if search
      @airport = find_by(:code => "#{search}")
      
    else
      self.all
    end
  end


    def sum
      inject(0.0) { |result, el| result + el }
    end

   	def avg 
   	  sum / size
	  end
end
