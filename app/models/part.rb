class Part < ApplicationRecord
  
  
  validates_presence_of :part_number

  has_many :sub_parts, dependent: :destroy
  belongs_to :project


end
