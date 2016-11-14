class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :horse, foreign_key: true
      t.date :validated_at
      t.date :date
      t.text :owner_comment
      t.integer :owner_rating
      t.text :user_comment
      t.integer :user_rating

      t.timestamps
    end
  end
end
