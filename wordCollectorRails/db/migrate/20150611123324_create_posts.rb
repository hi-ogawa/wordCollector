class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :word
      t.text :sentence
      t.text :picture

      t.timestamps
    end
  end
end
