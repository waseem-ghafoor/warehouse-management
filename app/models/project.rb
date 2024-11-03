class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :designs, dependent: :destroy
  has_many :parts, dependent: :destroy
  has_many :sub_parts, dependent: :destroy

  def as_json(complete_data = false, options = {})
    if complete_data
      super(
        options.merge(
          
          include: {
            designs: { only: %w[id design_id]},
            parts: {
              include: {
                sub_parts: {
                  methods: %i[qrcode_url worker_name]
                }
              }
            }
          }
        )
      )
    else
      super()
    end
  end
end