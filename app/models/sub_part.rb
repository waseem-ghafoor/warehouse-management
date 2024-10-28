class SubPart < ApplicationRecord
  belongs_to :part
  belongs_to :worker, class_name: "User", foreign_key: "worker_id"

  enum :stage, {
    cutting: 0,
    welding: 1,
    fabrication: 2,
    blasting: 3,
    painting: 4
  }

  enum :status, {
    not_started: 0,  
    started: 1,
    in_progress: 2,
    completed: 3
  }


  enum :quality_control, {
    not_done: 0,
    rejected: 1,
    approved: 2
  }


end
