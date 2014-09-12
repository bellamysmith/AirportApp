class Flight
  include Mongoid::Document
  field :airline
  field :flight_num
  belongs_to :airport
end
