include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :item do
    word        { FFaker::DizzleIpsum.words[0,2].join(" ") }
    sentence    { FFaker::DizzleIpsum.paragraph }
    meaning     { FFaker::DizzleIpsum.paragraph }
    association :category, factory: :category
    picture     { fixture_file_upload(Rails.root.join('spec', 'pictures', 'test.png'), 'image/png') }
  end
end
