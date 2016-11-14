class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.date :start_at
      t.date :finish_at
      t.references :horse, foreign_key: true

      t.timestamps
    end
  end
end
