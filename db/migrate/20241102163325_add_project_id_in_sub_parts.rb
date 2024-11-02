class AddProjectIdInSubParts < ActiveRecord::Migration[7.2]
  def change
    add_reference :sub_parts, :project, foreign_key: true
  end
end
