class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
