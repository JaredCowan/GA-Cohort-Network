$i   = 0
$num = 1
PASSWORD = 'password'

while $i < $num do
  email    = "example#{$i}@example.com"
  fn       = Faker::Name.first_name
  ln       = Faker::Name.last_name
  Faker::Name.first_name
  User.create!(
    :first_name => fn,
    :last_name  => ln,
    :user_name  => fn + ln,
    :email      => "#{email}",
    :password   => PASSWORD,
    :password_confirmation => PASSWORD
  )
  $i += 1
end