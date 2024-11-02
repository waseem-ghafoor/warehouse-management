class SubPart < ApplicationRecord

  has_one_attached :qrcode, dependent: :destroy
  belongs_to :design
  belongs_to :part
  belongs_to :worker, class_name: "User", foreign_key: "worker_id"

  enum :stage, {
    cutting: 0,
    fabrication: 1,
    fit_up: 2,
    welding: 3,
    blasting: 4,
    galvanzing: 5,
    painting: 6,
    shipping: 7
  }

  enum :status, {
    not_started: 0,  
    started: 1,
    in_progress: 2,
    completed: 3,
    on_hold: 4
  }


  enum :quality_control, {
    qc_pending: 0,
    rejected: 1,
    approved: 2
  }

  before_commit :generate_qrcode, on: :create


  def as_json (opt={})
    super().merge(qrcode_url)
  end
  
  def qrcode_url
    {
      "qrcode" => qrcode&.url
    }
  end
  private

  def generate_qrcode
      host = Rails.application.config.action_controller.default_url_options[:host]
      qrcode = RQRCode::QRCode.new({id: id, sub_part_no: sub_part_no, job_id: job_id}.to_json)
      png = qrcode.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: "black",
        file: nil,
        fill: "white",
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 120
      )

      self.qrcode.attach(
        io: StringIO.new(png.to_s),
        filename: "qrcode.png",
        content_type: "image/png",
      )
  end

end
