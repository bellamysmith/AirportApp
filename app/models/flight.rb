class Flight
  include Mongoid::Document
  field :airline
  field :flight_num
  belongs_to :airport

  validates_presence_of :airline
  validates_presence_of :flight_num
end
