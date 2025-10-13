class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.active.with_courses
    @selected_category = params[:category_id]

    # ✅ Show only courses available to the current user's company
    if current_user.company
      base_scope = current_user.company.courses.active
    else
      base_scope = Course.active
    end

    @courses =
      if @selected_category.present?
        base_scope.by_category(@selected_category)
      else
        base_scope
      end.order(created_at: :desc)
  end

  def show
    @course = Course.find(params[:id])

    # ✅ Optional: ensure user can only view assigned courses
    if current_user.company && !current_user.company.courses.include?(@course)
      redirect_to courses_path, alert: "You do not have access to this course."
    end
  end
end
