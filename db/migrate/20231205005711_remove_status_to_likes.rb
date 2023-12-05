class RemoveStatusToLikes < ActiveRecord::Migration[7.1]
  def change
    remove_column :likes, :status
  end
end
