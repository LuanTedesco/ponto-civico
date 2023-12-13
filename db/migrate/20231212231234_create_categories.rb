class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
