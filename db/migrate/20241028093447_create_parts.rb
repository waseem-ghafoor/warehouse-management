class CreateParts < ActiveRecord::Migration[7.2]
  def change
    create_table :parts do |t|
      t.string :part_number
      t.string :material
      t.string :dimension
      t.integer :quantity
      t.text :note
      t.references :project, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end