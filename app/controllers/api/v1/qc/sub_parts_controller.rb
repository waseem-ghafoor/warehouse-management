class Api::V1::Qc::SubPartsController < Api::V1::Qc::BaseController
  before_action :sub_part_load, only: %i[change_stage]

  def change_stage
    current_stage = @sub_part.stage
    if @sub_part.status == "completed"
      if  stage_secure_params[:quality_status] == 'approved' && stage_secure_params[:next_stage].present?
        @sub_part.quality_control = "qc_pending"
        @sub_part.stage = stage_secure_params[:next_stage]
        @sub_part.status = "not_started"
      elsif stage_secure_params[:quality_status] == 'approved' && stage_secure_params[:next_stage].nil?
        @sub_part.quality_control = "approved"
      elsif stage_secure_params[:quality_status] == 'rejected'
        @sub_part.quality_control = "rejected"
        @sub_part.status = "not_started"
      end
    else
      render json: { success: false, notice: 'Error updating stage.', errors: ['Status should be completd'] }, status: :unprocessable_entity and return
    end

    if @sub_part.save
      SubPartHistory.create(
        sub_part_id: @sub_part.id,
        qc_stage: current_stage,
        qc_status: stage_secure_params[:quality_status],
        qc_user_id: current_user.id,
        worker_id: @sub_part.worker_id,
        start_time: @sub_part.start_time,
        end_time: @sub_part.stop_time,
        time_taken: @sub_part.time_taken
      )
      render json: { success: true, notice: 'Status updated successfully', data: @sub_part.as_json }, status: :ok
    else
      render json: { success: false, notice: 'Error updating status.', errors: ['Status already marked completed'] }, status: :not_found and return
    end
  end

  private

  def sub_part_load
    @sub_part = SubPart.find_by_id(params[:id])

    unless @sub_part.present?
      render json: { success: false, notice: 'Error updating part.', errors: ['part not found'] }, status: :not_found and return
    end
  end

  def stage_secure_params
    params.permit(:next_stage, :quality_status)
  end
end
  