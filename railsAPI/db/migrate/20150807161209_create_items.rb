class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :word         , default: "" 
      t.text :sentence       , default: "" 
      t.text :meaning        , default: "" 
      t.references :category , index: true

      t.timestamps
    end
  end
end
