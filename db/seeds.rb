# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

alert.create(
	heures: "11",
	Minutes: "12",
	Lieu: "Paris",
	Active: true
	)
	
alert.create(
	heures: "13",
	Minutes: "14",
	Lieu: "Paris",
	Active: false
	)
