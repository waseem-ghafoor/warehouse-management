class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :parts, dependent: :destroy

  def as_json(complete_data=false, options = {})
    if complete_data
      super(
        options.merge(
          include: {
            parts: {
              include: :sub_parts
            }
          }
        )
      )
    else
      super()
    end
  end
end