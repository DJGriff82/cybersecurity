# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  def index
    @categories = Category.active.with_courses
    @selected_category = params[:category_id]
    
    @courses = if @selected_category.present?
                 Course.active.by_category(@selected_category)
               else
                 Course.active
               end.order(created_at: :desc)
  end

  def show
    @course = Course.find(params[:id])
  end
end