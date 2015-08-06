class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name,      default: "" 
      t.text :description, default: ""
      t.references :user, index: true

      t.timestamps
    end
  end
end
