class Api::V1::UsersController < ApplicationController
  before_action :load_user, only: [:show, :update, :destroy]

  def index
    prms = request.parameters
    if prms[:first]
      count = User.count
      render json: { first: count.zero? }, status: :ok
    else
      users = User.all.order(:id)
      render json: users, status: :ok
    end
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def login
    u = user_login_passw
    user = User.select(:isadmin, :name, :surname, :username, :id).find_by(username: u[:username], passw: u[:passw])
    if user
      render json: user, status: :ok
    else
      render json: { exists: false }, status: :not_found
    end
  end

  def request_question
    u = look_for
    user = User.select(:secret).find_by(username: u[:username])
    if user
      render json: user, status: :ok
    else
      render json: { exists: false }, status: :not_found
    end
  end

  def request_resp
    u = resp_for_reset
    user = User.find_by(username: u[:username], response: u[:response])
    if user
      render json: { ok: true }, status: :ok
    else
      render json: { exists: false }, status: :not_found
    end
  end

  def update_status
    u = look_for
    user = User.find_by(username: u[:username])
    if user.update(isadmin: !user[:isadmin])
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def update_passw
    u = user_login_passw
    user = User.find_by(username: u[:username])
    if user.update(passw: u[:passw])
      render json: { ok: true }, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :surname, :username, :email, :passw, :secret, :response, :isadmin)
  end

  def look_for
    params.require(:user).permit(:username).to_h
  end

  def resp_for_reset
    params.require(:user).permit(:username, :response).to_h
  end

  def user_login_passw
    params.require(:user).permit(:username, :passw).to_h
  end
end
