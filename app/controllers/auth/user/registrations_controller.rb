# frozen_string_literal: true

class Auth::User::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def sign_up_params
    params.permit(*params_for_resource(:sign_up),
                  :name, :role)
  end


  private
  
  def render_create_success
    render json: {
      status: true,
      message: 'User successfully created',
      data: resource_data(resource_json: @resource),
    }, status: :ok
  end

  def render_create_error
    full_messages = @resource.errors.full_messages

    render json: {
      status: false,
      data: resource_data(resource_json: @resource),
      errors: full_messages
    }, status: :unprocessable_entity
  end  
end