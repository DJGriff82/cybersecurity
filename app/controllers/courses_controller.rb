class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    begin
      @selected_category = params[:category_id].presence

      # Safe categories loading
      @categories = Category.active.with_courses.to_a

      # Base scope with safer company check
      base_scope = Course.active.includes(:category, :company, :creator)
      
      # Filter by company if user belongs to one
      if current_user&.company_id
        base_scope = base_scope.where(company_id: current_user.company_id)
      end

      # Filter by category if selected
      if @selected_category
        base_scope = base_scope.where(category_id: @selected_category)
      end

      @courses = base_scope.order(created_at: :desc).limit(100).to_a

    rescue => e
      Rails.logger.error("COURSES_INDEX_ERROR: #{e.message}\n#{e.backtrace.join("\n")}")
      @categories = []
      @courses = []
      flash.now[:alert] = "Courses are temporarily unavailable."
    end
  end

  def show
    begin
      @course = Course.find_by(id: params[:id])
      
      unless @course
        redirect_to courses_path, alert: "Course not found."
        return
      end

      # Check access rights
      if current_user.company_id && @course.company_id != current_user.company_id
        redirect_to courses_path, alert: "You do not have access to this course."
        return
      end

      @training_modules = @course.training_modules.order(:position).to_a

    rescue => e
      Rails.logger.error("COURSES_SHOW_ERROR: #{e.message}\n#{e.backtrace.join("\n")}")
      redirect_to courses_path, alert: "This course cannot be displayed at the moment."
    end
  end
end