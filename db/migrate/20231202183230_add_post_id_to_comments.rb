class AddPostIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :post, foreign_key: true
  end
end
