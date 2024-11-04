
# Ensure sample users are created
user1 = User.find_or_create_by(email: "user1@example.com") do |user|
  user.password = "password1"
  user.username = "user1"
  user.bio = "This is user1's bio."
  user.pfp_url = "https://example.com/user1.jpg"
end

user2 = User.find_or_create_by(email: "user2@example.com") do |user|
  user.password = "password2"
  user.username = "user2"
  user.bio = "This is user2's bio."
  user.pfp_url = "https://example.com/user2.jpg"
end

user3 = User.find_or_create_by(email: "user3@example.com") do |user|
  user.password = "password3"
  user.username = "user3"
  user.bio = "This is user3's bio."
  user.pfp_url = "https://example.com/user3.jpg"
end

# Create sample posts, checking if they exist first to avoid duplication
post1 = Post.find_or_create_by(author_id: user1.id, title: "My First Post") do |post|
  post.body = "This is the content of my very first post!"
end

post2 = Post.find_or_create_by(author_id: user1.id, title: "Another Day in Rails") do |post|
  post.body = "Learning Rails has been a fantastic journey so far."
end

post3 = Post.find_or_create_by(author_id: user2.id, title: "Hello from User2") do |post|
  post.body = "Excited to join this platform and share my thoughts!"
end

post4 = Post.find_or_create_by(author_id: user2.id, title: "User2’s Favorite Coding Tips") do |post|
  post.body = "Here's a list of my favorite coding tips and tricks."
end

# Add comments to each post
Comment.find_or_create_by(post: post1, user: user2) do |comment|
  comment.body = "Great first post! Can't wait to see more from you."
end

Comment.find_or_create_by(post: post1, user: user3) do |comment|
  comment.body = "Welcome to the community, user1! Nice post!"
end

Comment.find_or_create_by(post: post2, user: user2) do |comment|
  comment.body = "Rails is such a powerful framework! Keep going!"
end

Comment.find_or_create_by(post: post2, user: user3) do |comment|
  comment.body = "Awesome insights! I'm learning Rails too."
end

Comment.find_or_create_by(post: post3, user: user1) do |comment|
  comment.body = "Welcome, User2! Your enthusiasm is contagious!"
end

Comment.find_or_create_by(post: post3, user: user3) do |comment|
  comment.body = "Looking forward to seeing your contributions!"
end

Comment.find_or_create_by(post: post4, user: user1) do |comment|
  comment.body = "These tips are super helpful! Thanks for sharing."
end

Comment.find_or_create_by(post: post4, user: user3) do |comment|
  comment.body = "I love these coding tips! Can't wait to try them out."
end


user1.follow(user2)
user1.follow(user3)
user2.follow(user3)
user3.follow(user1)
user3.follow(user2)
