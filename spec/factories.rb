# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Daniel Randall"
  user.email                 "daniel@otherwhitenoise.com"
  user.password              "Pelican$"
  user.password_confirmation "Pelican$"
end

Factory.sequence :email do |n|
	"person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
	micropost.content     "Foo bar"
	micropost.association :user
end

