class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    if @category.save
      flash['notice'] = "Category #{params[:category][:name]} was created."
      redirect_to posts_path
    else
      render :new

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end