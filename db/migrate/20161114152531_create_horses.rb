class CreateHorses < ActiveRecord::Migration[5.0]
  def change
    create_table :horses do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.integer :price
      t.string :address
      t.boolean :equipment
      t.text :description
      t.string :photo

      t.timestamps
    end
  end
end
