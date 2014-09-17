class Airport
  include Mongoid::Document
  include ActiveModel::Validations
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

  validates_uniqueness_of :code, message: "That airport already exists"


  def self.search(search)
    if search
      if where(:code => "#{search}").exists?
        @airport = find_by(:code => "#{search}")
      
      else
        binding.pry
        self.all
      end
    end
  end

    def sum
      inject(0.0) { |result, el| result + el }
    end

   
end
