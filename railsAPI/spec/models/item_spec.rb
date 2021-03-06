require 'spec_helper'

describe Item do
  
  describe "has_attached_file :picture" do
    let(:item)             { FactoryGirl.create :item }
    let(:item_picture_nil) { FactoryGirl.create :item, picture: nil }

    describe "picture.url" do
      context "with `picture = fixture_file_upload`" do
        it { expect(item.picture.url).to match "/system/items/pictures/" }
      end

      context "with `picture = nil`" do
        it { expect(item_picture_nil.picture.url).to match "/images/missing.png" }
      end
    end

    describe "default values of sentence and meaning" do
      let(:item_sentence_meaning_nil) { FactoryGirl.build :item, sentence: nil, meaning: nil }
      it do
        item_sentence_meaning_nil.save
        expect(item_sentence_meaning_nil.sentence).to eq ""
        expect(item_sentence_meaning_nil.meaning).to eq ""
      end
    end
  end
end
