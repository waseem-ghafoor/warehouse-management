class Api::V1::SubPartsController < Api::V1::BaseController
  
  def index 
    @sub_parts = SubPart.all
    @sub_parts = @sub_parts.where(project_id: params[:project_id]) if params[:project_id]
    @sub_parts = @sub_parts.where(design_id: params[:design_id]) if params[:design_id]
    @sub_parts = @sub_parts.where(stage: params[:stage]) if params[:stage]



    @sub_parts = @sub_parts.paginate page: page, per_page: 100
    render json: { success: true, message: 'List of All sub parts', data: @sub_parts.as_json, meta_attributes: meta_attributes(@sub_parts) },
           status: :ok
  end

  def stats 
    @sub_parts = SubPart.all
    @sub_parts = @sub_parts.where(project_id: params[:project_id]) if params[:project_id]
    @sub_parts = @sub_parts.where(design_id: params[:design_id]) if params[:design_id]
    @sub_parts = @sub_parts.where(stage: params[:stage]) if params[:stage]

    data = {total_parts: @sub_parts.count,
            started: @sub_parts.by_status("started").count,
            in_progress: @sub_parts.by_status("in_progress").count,
            completed: @sub_parts.by_status("completed").count
          }
    render json: { success: true, message: 'stats', data: data},
           status: :ok
  end
end