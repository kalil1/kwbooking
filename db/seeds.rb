
require 'faker'

# Create Users
users = []
5.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: 'password123',
    provider: 'email',
    uid: Faker::Internet.uuid
  )
end

# Create Locations
locations = []
users.each do |user|
  2.times do
    locations << Location.create!(
      nickname: Faker::Address.community,
      city: Faker::Address.city,
      street_address: Faker::Address.street_address,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip_code,
      business_name: Faker::Company.name,
      user: user
    )
  end
end

# Create Clients
clients = []
users.each do |user|
  3.times do
    clients << Client.create!(
      name: Faker::Name.name,
      phone_number: Faker::PhoneNumber.phone_number,
      email: Faker::Internet.email,
      user: user
    )
  end
end

# Create Appointments
10.times do
  Appointment.create!(
    appointment_time: Faker::Time.forward(days: 30, period: :morning),
    duration: [30, 60, 90].sample,
    price: rand(50.0..200.0).round(2),
    location: locations.sample,
    user: users.sample,
    client: clients.sample
  )
end

puts 'Seeding completed successfully!'
