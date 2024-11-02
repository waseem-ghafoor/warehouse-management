class AddDesignIdInSubPart < ActiveRecord::Migration[7.2]
  def change
    add_reference :sub_parts, :design, foreign_key: true
  end
end
