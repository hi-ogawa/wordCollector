class AddMeaningColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :meaning, :text
    reversible do |change|
      change.up do
        Post.all.each do |p|
          p.update(meaning: 'test_meaning')
        end
      end
    end
  end
end
