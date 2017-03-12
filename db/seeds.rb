# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dam = Trip.create(name: "Dam with Bros", destination: "Amsterdam", created: false )
rome = Trip.create(name: "Rome with Love", destination: "Rome",created: false )
date_1 = DateTime.new(2017, 06, 13, 10)
date_2 = DateTime.new(2017, 06, 16, 10)
date_3 = DateTime.new(2017, 07, 11, 10)
date_4 = DateTime.new(2017, 06, 23, 10)
date_5 = DateTime.new(2017, 06, 28, 10)
TripDate.create(start_date: date_1, end_date: date_2, trip: dam)
TripDate.create(start_date: date_4, end_date: date_5, trip: dam)



