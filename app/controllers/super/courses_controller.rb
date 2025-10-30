# app/controllers/super/courses_controller.rb
module Super
  class CoursesController < BaseController
    before_action :authenticate_user!
    before_action :set_course, only: [:show, :edit, :update, :destroy, :toggle_status]

    def index
      # Preload associations your views use
      @courses = Course.includes(:creator, :company, :category).order(created_at: :desc)
    end

    def show
      @training_modules = @course.training_modules.order(:position)
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      # Avoid NoMethodError if session expired or user not present
      @course.created_by ||= current_user&.id

      if @course.save
        # OPTIONAL: if your form sends course[:company_id] but you also use the join table elsewhere,
        # uncomment to ensure the join exists too.
        #
        # if params.dig(:course, :company_id).present?
        #   CompanyCourse.find_or_create_by!(
        #     company_id: params[:course][:company_id],
        #     course: @course
        #   )
        # end

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
      @course = Course.find(params[:id])
    end

    def course_params
      # Keep company_id permitted since your views/controllers reference it
      params.require(:course).permit(
        :title, :description, :duration, :difficulty, :is_active, :company_id, :category_id, :created_by
      )
    end
  end
end
