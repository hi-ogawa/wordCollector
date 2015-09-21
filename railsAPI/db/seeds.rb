# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == "development"

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
      # picture     { fixture_file_upload(Rails.root.join('spec', 'pictures', 'test.png'), 'image/png') }
    end
  end


  user_hiogawa       = FactoryGirl.create      :user_seed,         username: "hiogawa",  email: "hiogawa@hiogawa.com"
  user_testest       = FactoryGirl.create      :user_seed,         username: "testest",  email: "test@test.com"
  categories_hiogawa = FactoryGirl.create_list :category_seed, 30, user: user_hiogawa
  categories_testest = FactoryGirl.create_list :category_seed, 30, user: user_testest

  items = 30.times.each do
    pic = fixture_file_upload(Rails.root.join('spec', 'pictures', 'test.png'), 'image/png')
    FactoryGirl.create :item_seed, picture: pic, category: categories_hiogawa.first
    pic.close
  end

  # itemss1     = categories1.map do |c|
  #   20.times.map do 
  #     pic = fixture_file_upload(Rails.root.join('spec', 'pictures', 'test.png'), 'image/png')
  #     FactoryGirl.create :item_seed, picture: pic, category: c
  #     pic.close
  #   end
  # end.flatten

  # itemss2     = categories2.map do |c|
  #   3.times.map do
  #     FactoryGirl.create :item_seed, category: c 
  #   end
  # end.flatten

end
