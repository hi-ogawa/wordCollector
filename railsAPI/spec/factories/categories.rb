FactoryGirl.define do
  factory :category do
    name        "MyString"
    description "MyText"
    user
  end

  factory :category_desc_empty, class: Category do
    name        "test"
    description ""
    user
  end

  factory :category_desc_nil, class: Category do
    name        "test"
    description nil
    user
  end
end
