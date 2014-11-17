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

# (2..5).each do |i|
    # Friendship.create(user_id: 1, friend_id: 2, status: 'requested')
    # Friendship.create(user_id: 2, friend_id: 3, status: 'requested')
    # Friendship.create(user_id: 2, friend_id: 4, status: 'requested')
    # Friendship.create(user_id: 2, friend_id: 5, status: 'requested')

    # Friendship.create(user_id: 1, friend_id: 3, status: 'requested')
    # Friendship.create(user_id: 3, friend_id: 6, status: 'requested')

# end

Friendship.create(user_id: 1, friend_id: 2, status: 'accepted')
Friendship.create(user_id: 1, friend_id: 3, status: 'accepted')
Friendship.create(user_id: 1, friend_id: 4, status: 'accepted')

Friendship.create(user_id: 3, friend_id: 6, status: 'requested')
Friendship.create(user_id: 3, friend_id: 5, status: 'requested')
Friendship.create(user_id: 2, friend_id: 14, status: 'requested')

Friendship.create(user_id: 45, friend_id: 1, status: 'requested')
Friendship.create(user_id: 44, friend_id: 1, status: 'requested')
Friendship.create(user_id: 22, friend_id: 1, status: 'requested')

# I requsted
# (5..24).each do |i|
#     Friendship.create(user_id: 1, friend_id: i, status: 'requested')
# end

# # requested of me
# (25..45).each do |i|
#     Friendship.create(user_id: i, friend_id: 1, status: 'requested')
# end




