# app/controllers/super/training_modules_controller.rb
module Super
  class TrainingModulesController < BaseController
    before_action :set_course
    before_action :set_training_module, only: [:show, :edit, :update, :destroy]

    def index
      @training_modules = @course.training_modules
    end

    def show; end

    def new
      @training_module = @course.training_modules.new
    end

    def create
      @training_module = @course.training_modules.new(training_module_params)
      if @training_module.save
        redirect_to super_course_path(@course), notice: "Training module created."
      else
        render :new
      end
    end

    def edit; end

    def update
      if @training_module.update(training_module_params)
        redirect_to super_course_path(@course), notice: "Training module updated."
      else
        render :edit
      end
    end

    def destroy
      @training_module.destroy
      redirect_to super_course_path(@course), notice: "Training module deleted."
    end

    private

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_training_module
      @training_module = @course.training_modules.find(params[:id])
    end

    def training_module_params
      params.require(:training_module).permit(:title, :content, :order)
    end
  end
end
