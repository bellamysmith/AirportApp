class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :overall_score, type: Integer, default: 5
  field :parking, type: Integer
  field :review_notes, type: String
  field :food_and_drink, type: Integer
  field :terminal, type: Integer
  field :international, type: String, default: ""
  field :tip, type: String
  field :good_for_layovers, type: String
  field :shopping, type: String
  field :free_wifi, type: String, default: ""
  field :wifi, type: String, default: ""
  
  belongs_to :user
  belongs_to :airport

  validates_presence_of :overall_score
  validates_presence_of :review_notes
end
