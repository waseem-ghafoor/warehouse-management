class Design < ApplicationRecord
  has_many :sub_parts, dependent: :destroy
  belongs_to :project
end
