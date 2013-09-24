# require 'faker'

# FactoryGirl.define do

#   factory :testbuild do
#     package { ["#{Rails.root}/spec/assets/test.apk", "#{Rails.root}/spec/assets/test.ipa"].sample }
#   end

#   factory :user do |f|
#     f.name {Faker::Name.name}
#     f.email {Faker::Internet.email}
#     f.password "testtest"
#     f.password_confirmation "testtest"
#   end

#   factory :customer do
#     name {Faker::Name.name}
#     image "http://placehold.it/200x200"
#     users FactoryGirl.create_list(:user,3)
#     projects {[FactoryGirl.create(:project)]}
#   end

#   factory :project do
#     name {Faker::Name.name}
#     customer FactoryGirl.build(:customer)
#     association :build
#   end

# end
