# app/controllers/super/module_pages_controller.rb
module Super
  class ModulePagesController < BaseController
    before_action :set_course
    before_action :set_training_module
    before_action :set_page, only: [:edit, :update, :destroy]

    def new
      @page = @training_module.module_pages.new
    end

    def create
      @page = @training_module.module_pages.new(page_params)
      if @page.save
        redirect_to edit_super_course_path(@course), notice: "Page created."
      else
        render :new
      end
    end

    def edit; end

    def update
      if @page.update(page_params)
        redirect_to edit_super_course_path(@course), notice: "Page updated."
      else
        render :edit
      end
    end

    def destroy
      @page.destroy
      redirect_to edit_super_course_path(@course), notice: "Page deleted."
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

   def page_params
  params.require(:module_page).permit(:title, :content, :order, :image, :video)
end

  end
end
