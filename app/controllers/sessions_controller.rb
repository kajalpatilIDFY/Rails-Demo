class SessionsController < ApplicationController
  def new
  end

  def create
    # params come in as session[email] and session[password] per the form we'll create
    user = User.find_by("lower(email) = ?", params.dig(:session, :email).to_s.downcase)
    if user&.authenticate(params.dig(:session, :password))
      session[:user_id] = user.id
      redirect_to tasks_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out."
  end
end
