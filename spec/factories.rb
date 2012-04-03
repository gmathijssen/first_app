# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.user_type             3
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :admin, :class => User do |admin|
  admin.name                  "Guus Mathijssen"
  admin.email                 "guus@example.com"
  admin.user_type             1
  admin.password              "foobar"
  admin.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end