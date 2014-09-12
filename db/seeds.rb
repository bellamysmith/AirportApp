# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Airport.destroy_all
Review.destroy_all

users = User.create([
	{
		name: "Bellamy", 
		email: 'bellamy@bellamy.com',
		password: 'password'
		}])

airports = Airport.create([
	{
		name: "LAX", 
		city: "Los Angeles", 
		state: "CA"

		},
	{
		name: "ATL",
		city: "Atlanta", 
		state: "GA"
		}])

reviews = Review.create([
	{
		overall_score: 9, 
		parking: 3, 
		review_notes: "This place is great",
		food_and_drink: 3, 
		user: users[0],
		airport: airports[0]
		
		
}])





