class Api::V1::Worker::SubPartsController < Api::V1::Worker::BaseController
  before_action :sub_part_load, only: %i[change_status]

  def change_status
    if @sub_part.status == "not_started"
      @sub_part.status = "started"
      @sub_part.start_time = Time.now
      @sub_part.worker = current_user
    elsif @sub_part.status == "started"
      unless @sub_part.worker == current_user
        render json: { success: false, notice: 'Not Authorize', errors: ['You are not authorized to mark this order completed'] }, status: :unprocessable_entity and return
      end
      @sub_part.status = "completed"
      @sub_part.stop_time = Time.now
      @sub_part.time_taken = ((Time.now - @sub_part.start_time) / 60).to_i

    else
      render json: { success: false, notice: 'Error updating status.', errors: ['Status already marked completed'] }, status: :unprocessable_entity and return
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
end
  