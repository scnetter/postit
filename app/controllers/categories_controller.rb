class CategoriesController < ApplicationController

  before_action :require_user, only: [:new]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    if @category.save
      flash['notice'] = "Category #{params[:category][:name]} was created."
      redirect_to root_path
    else
      render :new
    end
  end
end
