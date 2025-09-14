class CoursePagesController < ApplicationController
  before_action :set_course
  before_action :set_training_module
  before_action :set_page

  def show
    # find next/previous pages for navigation
    @next_page = @training_module.module_pages.where("id > ?", @page.id).order(:id).first
    @prev_page = @training_module.module_pages.where("id < ?", @page.id).order(:id).last
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_training_module
    @training_module = @course.training_modules.find(params[:training_module_id])
  end

  def set_page
    @page = @training_module.module_pages.find(params[:id])
  end
end
