user_1 = User.create(first_name: "Antoine", last_name: "Guilguet", email:"guilguet.antoine@gmail.com", password: "brausadent1")
user_2 = User.create(first_name: "Antoine", last_name: "2", email:"antoine.guilguet@hec.edu", password: "allezlom")

dam = Trip.create(name: "Dam with Bros", destination: "Amsterdam", created: false )
participant_1 = TripParticipant.create(trip_id: dam.id, user_id: user_1.id)
participant_2 = TripParticipant.create(trip_id: dam.id, user_id: user_2.id)
rome = Trip.create(name: "Rome with Love", destination: "Rome",created: false )
particpant_3 = TripParticipant.create(trip_id: rome.id, user_id: user_1.id)

countries = CS.countries.keys
countries.each do |country|
  CS.states(country).keys.each do |state|
    CS.cities(country, state) do |city|
      City.create(name: city)
    end
  end
end





