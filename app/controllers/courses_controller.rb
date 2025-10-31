class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @selected_category = params[:category_id].presence

    # Categories list should never 500
    @categories =
      if Category.respond_to?(:active) && Category.respond_to?(:with_courses)
        Category.active.with_courses
      else
        Category.all
      end

    base_scope =
      if current_user&.company && Company.new.respond_to?(:courses)
        current_user.company.courses
      else
        Course.all
      end

    # Only active courses, eager-load what views touch
    base_scope = base_scope.active.includes(:category, :company, :creator)

    @courses =
      if @selected_category
        base_scope.by_category(@selected_category)
      else
        base_scope
      end.order(created_at: :desc).limit(100)

  rescue => e
    Rails.logger.error("COURSES_INDEX_FAIL: #{e.class}: #{e.message}")
    @categories = []
    @courses    = []
    flash.now[:alert] = "Courses are temporarily unavailable."
    render :index, status: :ok
  end

  def show
    @course = Course.find(params[:id])

    if current_user&.company && Company.new.respond_to?(:courses)
      unless current_user.company.courses.exists?(@course.id)
        redirect_to courses_path, alert: "You do not have access to this course." and return
      end
    end

    @training_modules = @course.training_modules.order(:position)

  rescue ActiveRecord::RecordNotFound
    redirect_to courses_path, alert: "Course not found."
  rescue => e
    Rails.logger.error("COURSES_SHOW_FAIL: #{e.class}: #{e.message}")
    redirect_to courses_path, alert: "That course can’t be displayed right now."
  end
end
