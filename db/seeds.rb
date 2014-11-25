# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Friendship.destroy_all

user1 = User.create(name: 'fidel', email: 'fidel@fidel.com', password: 'fidelfidel', password_confirmation: 'fidelfidel')
(2..50).each do |i|
    name = Faker::Name.name
    User.create(name: name, email: "example-#{i+1}@railstutorial.org", password: 'fidelfidel', password_confirmation: 'fidelfidel')
end

users = User.all

5.times do
    content = Faker::Lorem.sentence(5)
    users.each {|user| user.posts.create!(content: ("user " +  user.id.to_s + " " + content))}
end

users.each do |user|
    20.times do
        id = rand(Post.count)
        if id != 0
            sampled_post = Post.find(id)
            if user.liking?(sampled_post)
            else
                user.like(sampled_post)
                body = Faker::Lorem.sentence(5)
                sampled_post.comments.create!(body: ("user " + user.id.to_s + " post " + sampled_post.id.to_s + " ") + body, user_id: user.id)
            end
        end
    end
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

Friendship.create(user_id: 50, friend_id: 1, status: 'requested')
Friendship.create(user_id: 49, friend_id: 1, status: 'requested')
Friendship.create(user_id: 48, friend_id: 1, status: 'requested')

Friendship.create(user_id: 35, friend_id: 1, status: 'requested')
Friendship.create(user_id: 34, friend_id: 1, status: 'requested')
Friendship.create(user_id: 33, friend_id: 1, status: 'requested')

Friendship.create(user_id: 21, friend_id: 1, status: 'requested')
Friendship.create(user_id: 20, friend_id: 1, status: 'requested')
Friendship.create(user_id: 19, friend_id: 1, status: 'requested')

# I requsted
# (5..24).each do |i|
#     Friendship.create(user_id: 1, friend_id: i, status: 'requested')
# end

# # requested of me
# (25..45).each do |i|
#     Friendship.create(user_id: i, friend_id: 1, status: 'requested')
# end




