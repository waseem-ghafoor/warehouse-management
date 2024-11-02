class SubPartHistory < ApplicationRecord

  belongs_to :qc_user, class_name: "User", foreign_key: "qc_user_id"
  belongs_to :sub_part
  enum :qc_status, {
    qc_pending: 0,
    rejected: 1,
    approved: 2
  }

  enum :qc_stage, {
    cutting: 0,
    fabrication: 1,
    fit_up: 2,
    welding: 3,
    blasting: 4,
    galvanizing: 5,
    painting: 6,
    shipping: 7
  }

  def as_json(options = {})
    super(
      options.merge(
        include: {
          qc_user: { only: %w[id name]},
        }
      )
    )
  end
end
