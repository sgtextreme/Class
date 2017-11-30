class Bands < ActiveRecord::Migration[5.1]
  def change
    created_at :bands do |t|
      t.string :name, null: false 
      t.timestamps
  end
end
