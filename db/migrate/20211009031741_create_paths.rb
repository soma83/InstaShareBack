class CreatePaths < ActiveRecord::Migration[6.1]
  def change
    create_table :paths do |t|
      t.string :name, null: false, unique: true
      t.decimal :size, null: false
      t.string :public, default: 'no'
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
