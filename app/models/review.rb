class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  field :overall_score, type: Integer, default: 5
  field :parking, type: Integer
  field :review_notes, type: String
  field :food_and_drink, type: Integer
  belongs_to :user
  belongs_to :airport
end
