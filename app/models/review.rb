class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :overall_score, type: Integer, default: 5
  field :parking, type: Integer
  field :review_notes, type: String
  field :food_and_drink, type: Integer
  field :terminal, type: Integer
  field :international, type: Boolean
  field :tip, type: String
  field :good_for_layovers, type: String
  field :shopping, type: String
  field :free_wifi, type: Boolean
  field :wifi, type: Boolean
  
  belongs_to :user
  belongs_to :airport
end
