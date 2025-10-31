module Super
  class CoursesController < BaseController
    before_action :authenticate_user!
    before_action :set_course, only: [:show, :edit, :update, :destroy, :toggle_status]

    def index
      @courses = Course.includes(:creator, :company, :category)
                      .order(created_at: :desc)
                      .limit(100)
                      .to_a
    rescue => e
      Rails.logger.error("SUPER_COURSES_INDEX_FAIL: #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}")
      @courses = []
      flash.now[:alert] = "Courses are temporarily limited while we update the site."
      render :index, status: :ok
    end

    def show
      @training_modules = @course.training_modules.order(:position).to_a
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      @course.created_by ||= current_user&.id

      if @course.save
        redirect_to super_course_path(@course), notice: 'Course was successfully created.'
      else
        Rails.logger.error "Course create failed: #{@course.errors.full_messages.join(', ')}"
        flash.now[:alert] = @course.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @course.update(course_params)
        redirect_to super_course_path(@course), notice: 'Course was successfully updated.'
      else
        Rails.logger.error "Course update failed: #{@course.errors.full_messages.join(', ')}"
        flash.now[:alert] = @course.errors.full_messages.to_sentence
        render :edit, status: :unprocessable_entity
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
      @course = Course.find_by(id: params[:id])
      unless @course
        redirect_to super_courses_path, alert: "Course not found."
        return
      end
    end

    def course_params
      params.require(:course).permit(
        :title, :description, :duration, :difficulty, :is_active, :company_id, :category_id, :created_by
      )
    end
  end
end