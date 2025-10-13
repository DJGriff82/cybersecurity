# app/controllers/super/base_controller.rb
module Super
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_super_user

    private

    def require_super_user
      redirect_to root_path, alert: "You are not authorized to access this area." unless current_user&.super_user?

    end
  end
end