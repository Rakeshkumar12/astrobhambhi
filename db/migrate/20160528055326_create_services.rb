class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.integer :amount
      t.string :image

      t.timestamps null: false
    end
  end
end
