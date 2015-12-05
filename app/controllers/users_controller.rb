class UsersController < ApplicationController

  before_action :require_user, only: [:edit]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash['notice'] = "Userid #{@user.username} was created successfully."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
