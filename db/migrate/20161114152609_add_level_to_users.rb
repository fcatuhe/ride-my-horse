class AddLevelToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :level, foreign_key: true
  end
end
