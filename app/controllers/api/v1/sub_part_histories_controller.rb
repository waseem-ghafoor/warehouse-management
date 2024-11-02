class Api::V1::SubPartHistoriesController < Api::V1::BaseController
  # sub_part_histories_controller
  before_action :sub_part_load

  def index
    @sub_part_histories = @sub_part.sub_part_histories
    render json: { success: true, message: 'List of All histories', data: @sub_part_histories.as_json},
           status: :ok
  end


  private

  def sub_part_load
    @sub_part = SubPart.find(params[:sub_part_id])
  end
end