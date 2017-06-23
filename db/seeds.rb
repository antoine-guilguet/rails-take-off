puts "Destroying DB"


Trip.destroy_all
Survey.destroy_all
User.destroy_all

puts "Seeding users"

# user_1 = User.create(first_name: "Antoine", last_name: "Guilguet", email:"guilguet.antoine@gmail.com", password: "brausadent1")
# user_2 = User.create(first_name: "Antoine", last_name: "Test", email:"antoine.guilguet@hec.edu", password: "allezlom")
#
# puts "Seeding trip"
#
# dam = Trip.create(name: "Dam with Bros", destination: "Amsterdam", user_id: user_1.id)
# participant_1 = TripParticipant.create(trip_id: dam.id, user_id: user_1.id)
# participant_2 = TripParticipant.create(trip_id: dam.id, user_id: user_2.id)
#
# rome = Trip.create(name: "Rome with Love", destination: "Rome", user_id: user_2.id)
# particpant_3 = TripParticipant.create(trip_id: rome.id, user_id: user_1.id)
# participant_2 = TripParticipant.create(trip_id: rome.id, user_id: user_2.id)





