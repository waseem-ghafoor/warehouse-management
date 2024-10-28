class CreateSubParts < ActiveRecord::Migration[7.2]
  def change
    create_table :sub_parts do |t|
      t.float :part_number
      t.string :sub_part_no
      t.string :job_id
      t.string :sap_order_number
      t.integer :status
      t.float :height
      t.float :width
      t.float :length
      t.integer :qty_no
      t.float :per_qty
      t.float :totat_qty
      t.datetime :start_time
      t.datetime :stop_time
      t.integer :time_taken
      t.integer :stage
      t.integer :quality_control
      t.text :note
      t.references :part, null: false, foreign_key: true, index: true
      t.references :worker, null: false, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end
  end
end
