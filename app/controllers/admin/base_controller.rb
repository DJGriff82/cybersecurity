# app/controllers/admin/base_controller.rb
module Admin
  class BaseController < ApplicationController
    before_action :authorize_company_admin

    private

    def authorize_company_admin
      unless (current_user&.company_admin? || current_user&.super_user?) && current_user&.company
        flash[:alert] = "Access denied. Company admin privileges required and must be associated with a company."
        redirect_to root_path
      end
    end
  end
end
