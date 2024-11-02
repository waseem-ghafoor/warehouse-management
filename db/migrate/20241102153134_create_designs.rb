class CreateDesigns < ActiveRecord::Migration[7.2]
  def change
    create_table :designs do |t|
      t.string :design_id
      t.references :project, null: false, foreign_key: true, index: true
      
      t.timestamps
    end
  end
end
