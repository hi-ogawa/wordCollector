# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FactoryGirl.define do
  factory :user_seed, class: User do
    password "12345678"
    password_confirmation "12345678"
  end
end

FactoryGirl.define do
  factory :category_seed, class: Category do
    name        { FFaker::Movie.title }
    description { FFaker::DizzleIpsum.sentence }
  end
end

FactoryGirl.define do
  factory :item_seed, class: Item do
    word        { FFaker::DizzleIpsum.words[0,2].join(" ") }
    sentence    { FFaker::DizzleIpsum.sentence }
    meaning     { FFaker::DizzleIpsum.sentence }
    picture     { fixture_file_upload(Rails.root.join('spec', 'pictures', 'test.png'), 'image/png') }
  end
end


user1       = FactoryGirl.create :user_seed, {username: "hiogawa", email: "hiogawa@hiogawa.com"}
user2       = FactoryGirl.create :user_seed, {username: "testtest", email: "test@test.com"}
categories1 = 5.times.map{FactoryGirl.create :category_seed, user: user1}
categories2 = 3.times.map{FactoryGirl.create :category_seed, user: user2}
itemss1     = categories1.map{|c| 15.times.map {puts "creates items"; FactoryGirl.create :item_seed, category: c}}.flatten
itemss2     = categories2.map{|c| 3.times.map {FactoryGirl.create :item_seed, category: c}}.flatten
