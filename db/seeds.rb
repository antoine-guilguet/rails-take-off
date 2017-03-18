
dam = Trip.create(name: "Dam with Bros", destination: "Amsterdam", created: false )
user_1 = TripParticipant.create(trip: dam, user: User.first) 
user_1 = TripParticipant.create(trip: dam, user: User.last)
rome = Trip.create(name: "Rome with Love", destination: "Rome",created: false )
user_1 = TripParticipant.create(trip: rome, user: User.last)
date_1 = DateTime.new(2017, 06, 13, 10)
date_2 = DateTime.new(2017, 06, 16, 10)
date_3 = DateTime.new(2017, 07, 11, 10)
date_4 = DateTime.new(2017, 06, 23, 10)
date_5 = DateTime.new(2017, 06, 28, 10)
TripDate.create(start_date: date_1, end_date: date_2, trip: dam)
TripDate.create(start_date: date_4, end_date: date_5, trip: dam)




