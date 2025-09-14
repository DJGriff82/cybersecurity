# app/controllers/super/base_controller.rb
module Super
  class BaseController < ApplicationController
    before_action :authorize_super_user

    private

    def authorize_super_user
      unless current_user&.super_user?
        flash[:alert] = "Access denied. Super user privileges required."
        redirect_to root_path
      end
    end
  end
end