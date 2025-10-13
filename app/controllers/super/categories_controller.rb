# app/controllers/super/categories_controller.rb
module Super
  class CategoriesController < BaseController
    before_action :set_category, only: [:show, :edit, :update, :destroy, :toggle_status]

    def index
      @categories = Category.all.order(name: :asc)
    end

    def show
      @courses = @category.courses.active
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to super_category_path(@category), notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        redirect_to super_category_path(@category), notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to super_categories_path, notice: 'Category was successfully destroyed.'
    end

    def toggle_status
      @category.update(is_active: !@category.is_active)
      redirect_to super_categories_path, notice: "Category #{@category.is_active ? 'activated' : 'deactivated'}."
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description, :is_active)
    end
  end
end