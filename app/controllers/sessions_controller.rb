class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Logged in"
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid email/password"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "Bye"
    redirect_to root_path
  end
end
