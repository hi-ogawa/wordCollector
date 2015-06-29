class ChangeColumnTypeInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :sentence, :text
  end
end
