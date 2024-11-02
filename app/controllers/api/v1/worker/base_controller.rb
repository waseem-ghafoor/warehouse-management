module Api::V1::Worker
  class BaseController < ApplicationController
    before_action :authenticate_user!
    # before_action :authorize_roles!
    include Api::Pagination

    def authorize_roles!
      unless current_user.admin?
        render json: { success: false, notice: 'Not Authorize', errors: ['You are not authorized to perform this action'] }, status: :forbidden and return
      end
    end

    def per_page
      params.fetch(:per_page, 10)
    end

    def page
      params.fetch(:page, 1)
    end
  end
end