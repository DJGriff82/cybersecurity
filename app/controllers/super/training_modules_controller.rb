class Super::TrainingModulesController < ApplicationController
  before_action :set_course
  before_action :set_training_module, only: [:show, :edit, :update, :destroy]

  def index
    @training_modules = @course.training_modules
  end

  def show
  end

  def new
    @training_module = @course.training_modules.build
  end

  def create
    @training_module = @course.training_modules.build(training_module_params)
    if @training_module.save
      redirect_to super_course_training_modules_path(@course), notice: "Training module created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @training_module.update(training_module_params)
      redirect_to super_course_training_module_path(@course, @training_module), notice: "Training module updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @training_module.destroy
    redirect_to super_course_training_modules_path(@course), notice: "Training module deleted."
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_training_module
    @training_module = @course.training_modules.find(params[:id])
  end

  def training_module_params
    params.require(:training_module).permit(:title, :description, :content)
  end
end
