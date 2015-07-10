class MoveToPaperclipInPosts < ActiveRecord::Migration

  # how make change, up and down coexist 
  # http://makandracards.com/makandra/29223-how-to-combine-change-up-and-down-in-a-rails-migration
  def change # won't go back
    remove_column :posts, :picture, :text
    rename_column :posts, :picture_pc_file_name   ,  :picture_file_name    
    rename_column :posts, :picture_pc_content_type,  :picture_content_type 
    rename_column :posts, :picture_pc_file_size   ,  :picture_file_size    
    rename_column :posts, :picture_pc_updated_at  ,  :picture_updated_at
    reversible do |change|
      folder_before = Rails.root.join 'public/system/posts/picture_pcs'
      folder_after  = Rails.root.join 'public/system/posts/pictures'
      change.up do
        `mv #{folder_before} #{folder_after}`
      end
      change.down do
        `mv #{folder_after} #{folder_before}`
      end
    end
  end
end
