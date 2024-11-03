class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :project_load, only: %i[show]

  def index 
    @projects = Project.all.order(created_at: :desc)
    
    @projects = @projects.paginate page: page, per_page: per_page
    render json: { success: true, message: 'List of All Projects', data: @projects.as_json, meta_attributes: meta_attributes(@projects) },
           status: :ok
  end

  def create
    @project = Project.new
    @project.name = project_params[:name]
    if @project.save

      importer = Projects::PartsImporter.new(@project, project_params[:file].path)
      importer.import

      render json: { success: true, message: "#{importer.success_import} rows has been imported successfully.", errors: importer.errors, data: @project.as_json(true)}, status: :ok
    else
      render json: { success: false, notice: 'Error adding project.', errors: @project.errors }, status: :unprocessable_entity
    end
  end

  def show
    if @project.present?
      render json: { success: true, notice: 'project', data: @project.as_json(true) }, status: :ok
    else
      render json: { success: false, notice: 'Error updating project.', errors: ['project not found'] }, status: :not_found
    end
  end

  private

  def project_params
    params.permit(:name, :file)
  end

  def project_load
    @project = Project.find(params[:id])
  end
end
