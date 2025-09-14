# app/controllers/super/courses_controller.rb
module Super
  class CoursesController < BaseController
    before_action :set_course, only: [:show, :edit, :update, :destroy, :toggle_status]

    def index
      @courses = Course.includes(:creator, :company, :category).order(created_at: :desc)
    end

    def show
      @training_modules = @course.training_modules.order(:order)
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      @course.created_by = current_user.id

      if @course.save
        redirect_to super_course_path(@course), notice: 'Course was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @course.update(course_params)
        redirect_to super_course_path(@course), notice: 'Course was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @course.destroy
      redirect_to super_courses_path, notice: 'Course was successfully destroyed.'
    end

    def toggle_status
      @course.update(is_active: !@course.is_active)
      redirect_to super_courses_path, notice: "Course #{@course.is_active ? 'activated' : 'deactivated'}."
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :duration, :difficulty, :is_active, :company_id, :category_id)
    end
  end
end