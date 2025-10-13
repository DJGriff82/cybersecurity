# app/controllers/super/dashboard_controller.rb
module Super
  class DashboardController < BaseController
    def index
      @companies = Company.all
      @total_users = User.count
      @active_courses = Course.active.count
      @recent_users = User.order(created_at: :desc).limit(5)
    end
  end
end