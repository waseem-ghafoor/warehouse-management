class CreateSubPartHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :sub_part_histories do |t|
      t.references :sub_part, null: false, foreign_key: true, index: true
      t.integer :qc_stage
      t.integer :qc_status
      t.string :qc_note
      t.references :qc_user, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
