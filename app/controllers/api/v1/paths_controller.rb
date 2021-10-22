class Api::V1::PathsController < ApplicationController
  before_action :load_user, only: [:index, :create, :update, :destroy, :rename_file, :change_status, :download]

  def show
    render json: Path.find(params[:id])
  end

  def index
    prms = request.parameters
    if prms[:public] == 'true'
      files = @user.paths.find_by(public: 'true')
      render json: files
    else
      render json: @user.paths.all
    end
  end

  def rename_file
    path = @user.paths.find(params[:path_id])
    if path.update(name: params[:new_name])
      render json: {ok: true}, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def change_status
    path = @user.paths.find(params[:path_id])
    if path.update(public: path[:public] == 'false' ? 'true' : 'false')
      render json: {ok: true}, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def create
    path = @user.paths.create(path_params)
    if path.save
      render json: path, status: :created
    else
      render json: {errors: path.errors}, status: :unprocessable_entity
    end
  end

  def download
    u = @user
    path = u.paths.find(params[:path_id])
    url = url_for(path.file_element)
    render json: {url: url}, status: :ok
  end

  def destroy
    u = @user
    path = u.paths.find(params[:id])
    path.file_element.purge
    if path.destroy
      render json: {removed: true}, status: :ok
    else
      render json: {errors: path.errors}, status: :unprocessable_entity
    end
  end

  def update
    path = @user.paths.find(params[:id])
    if path.update(path_params)
      render json: path, status: :ok
    else
      render json: {errors: path.errors}, status: :unprocessable_entity
    end
  end

  private

  def path_params
    params.require(:path).permit(:name, :size, :public, :file_element)
  end

  def load_user
    @user = User.find(params[:user_id])
  end
end
