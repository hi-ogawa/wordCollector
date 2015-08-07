FactoryGirl.define do
  factory :category do
    name        {FFaker::Movie.title}
    description {FFaker::DizzleIpsum.paragraph}
    association :user, factory: :user
  end

  factory :category_desc_empty, class: Category do
    name        {FFaker::Movie.title}
    description ""
    association :user, factory: :user
  end

  factory :category_desc_nil, class: Category do
    name        {FFaker::Movie.title}
    description nil
    association :user, factory: :user
  end
end
