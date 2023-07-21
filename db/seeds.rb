# db/seeds.rb

# Create an admin user with Devise User model
admin_user = User.create!(
  email: 'fevinbiju1414@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

puts "Admin user created with email: #{admin_user.email}"

# Create an admin user with Devise AdminUser model (only in development environment)
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end
