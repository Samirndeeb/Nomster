class AddUserIdToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :user_id
  end
end
