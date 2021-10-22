class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :username, null: false 
      t.index :username, unique: true
      t.string :email, null: false
      t.index :email, unique: true
      t.string :passw, null: false
      t.string :secret, null: false
      t.string :response, null: false
      t.boolean :isadmin, default: false

      t.timestamps
    end
  end
end
