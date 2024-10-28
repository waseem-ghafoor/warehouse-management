class Api::V1::Qc::SubPartsController < Api::V1::Qc::BaseController
  before_action :sub_part_load, only: %i[change_stage]

  def change_stage
    if @sub_part.status == "completed"
      @sub_part.quality_control = stage_secure_params[:quality_status]
      @sub_part.stage = stage_secure_params[:next_stage] if stage_secure_params[:next_stage].present? && stage_secure_params[:quality_status] == "approved"
      @sub_part.status = "not_started" if stage_secure_params[:quality_status].present? && stage_secure_params[:quality_status] == "approved"
    else
      render json: { success: false, notice: 'Error updating stage.', errors: ['Status should be completd'] }, status: :unprocessable_entity and return
    end

    if @sub_part.save
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
  