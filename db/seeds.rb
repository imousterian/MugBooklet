# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Friendship.destroy_all

User.create(name: 'fidel', email: 'fidel@fidel.com', password: 'fidelfidel', password_confirmation: 'fidelfidel')
(2..50).each do |i|
    User.create(name: "fidel#{i}", email: "fidel#{i}@fidel.com", password: 'fidelfidel', password_confirmation: 'fidelfidel')
end

Friendship.create(user_id: 1, friend_id: 2, status: 'accepted')
Friendship.create(user_id: 1, friend_id: 3, status: 'accepted')
Friendship.create(user_id: 1, friend_id: 4, status: 'accepted')
Friendship.create(user_id: 1, friend_id: 5, status: 'accepted')
Friendship.create(user_id: 1, friend_id: 6, status: 'pending')
Friendship.create(user_id: 1, friend_id: 7, status: 'requested')





