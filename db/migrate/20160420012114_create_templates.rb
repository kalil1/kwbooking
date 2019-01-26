class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.string :nickname
      t.string :city
      t.string :street_address
      t.string :state
      t.string :zipcode
      t.string :business_name
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
