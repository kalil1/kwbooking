class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.string :nickname
      t.string :src
      t.string :iframe
      t.integer :price
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
