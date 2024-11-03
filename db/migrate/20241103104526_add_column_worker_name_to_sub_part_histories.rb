class AddColumnWorkerNameToSubPartHistories < ActiveRecord::Migration[7.2]
  def change
    add_reference :sub_part_histories, :worker, foreign_key: { to_table: :users }, index: true
    add_column :sub_part_histories, :start_time, :datetime
    add_column :sub_part_histories, :end_time, :datetime
    add_column :sub_part_histories, :time_taken, :integer
  end
end