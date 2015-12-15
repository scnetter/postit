class UsersController < ApplicationController

  before_action :require_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update, :show]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash['notice'] = "Userid #{@user.username} was registered successfully."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash['notice'] = 'User was updated.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    @user = User.find_by_slug(params[:id])
  end
end
