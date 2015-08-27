require 'spec_helper'

describe Category do
  let(:category)            {FactoryGirl.build(:category)}
  let(:category_desc_empty) {FactoryGirl.build(:category_desc_empty)}
  let(:category_desc_nil)   {FactoryGirl.build(:category_desc_nil)}

  it "allows description to be empty string" do
    expect(category_desc_empty.save).to be true
  end

  it "puts empty string into description by default" do
    category_desc_nil.save
    expect(category_desc_nil.description).to eq ""
  end
end
