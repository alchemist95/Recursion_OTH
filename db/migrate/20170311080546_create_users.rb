class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :college
      t.string :uid
      t.string :provider
      t.integer :role
      t.string :password
      t.integer :score
      t.string :image_url

      t.timestamps
    end
  end
end
