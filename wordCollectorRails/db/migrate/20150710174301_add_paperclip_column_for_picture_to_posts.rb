class AddPaperclipColumnForPictureToPosts < ActiveRecord::Migration
  def up
    add_attachment :posts, :picture_pc
  end

  def down
    remove_attachment :posts, :picture_pc
  end
end
