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
        self.all
      end
    end
  end

  def sum
    inject(0.0) { |result, el| result + el }
  end

  def score
    
    overall = []
    self.reviews.each do |r|
        overall.push(r.overall_score)    
    end 
    if overall.length > 0 
      overall.reduce(:+) / overall.length
    else
      "not rated"
    end
  end


  def free_wifi?
    free_wifi = []
    self.reviews.each do |r| 
      free_wifi.push(r.free_wifi)
    end
    
    truth = free_wifi.count("Yes")
    falses = free_wifi.count("No")

    if truth > falses
      free_wifi = "Yes"
    
    elsif falses > truth
      free_wifi = "No"
    else
      free_wifi = "unknown"
    end

  end
  def wifi?
    wifi = []
    self.reviews.each do |r|
      wifi.push(r.wifi)
    end
    truth = wifi.count(true)
    falses = wifi.count(false)

    if truth > falses
      wifi = "Yes"
    elsif falses > truth
      wifi = "No"
    else
      wifi = "Unknown"
    end
  end
        
end
