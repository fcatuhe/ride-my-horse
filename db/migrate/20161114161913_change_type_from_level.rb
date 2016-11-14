class ChangeTypeFromLevel < ActiveRecord::Migration[5.0]
  def change
    rename_column :levels, :type, :name
  end
end
