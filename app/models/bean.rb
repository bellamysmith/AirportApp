class Bean
  include Mongoid::Document
  field :name, type: String
  field :roast, type: String
  field :origin, type: String
  field :overall_review, type: Float
  field :body, type: Integer
  field :flavor, type: Integer
  field :with_milk, type: Integer
  has_many :reviews
end
