class SessionsController < ApplicationController
  def new
  end

  def create
    flash['error'] = nil
    # 1. get user
    # 2. password match?
    # 3. If yes, set session data
    # 4. If no, render new form again.
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash['notice'] = "#{user.username} has been logged in."
      redirect_to root_path
    else
      flash['error'] = 'There is a problem with your username or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
