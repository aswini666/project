class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:type].present?
      search = params[:search]
      @users = User.all.where("lower(fname) LIKE ?", "%#{search}%")
    else
      @users = User.all
    end
  end

  def show    
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
        redirect_to @user
    else 
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def search
    if params[:search].blank?
      redirect_to users_path and return
    else
      parameter = params[:search].downcase
      redirect_to users_path(:search => parameter, :type => "search")
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fname, :lname, :phnum, :address, :email)
  end    
end
