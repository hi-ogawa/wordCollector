require 'spec_helper'

describe Category do
  let(:category)            {FactoryGirl.build(:category)}
  let(:category_desc_empty) {FactoryGirl.build(:category_desc_empty)}
  let(:category_desc_nil)   {FactoryGirl.build(:category_desc_nil)}

  it "allows description to be empty string" do
    expect(category_desc_empty.save).to be true
  end

  it "doesn't allow description to be nil" do
    category_desc_nil.save
    expect(category_desc_nil.errors[:description]).to include "can't be nil"
  end

end
