class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.where(user_status: 0)
  end

  def show
    @user = User.find(params[:id])
    @pet_records = PetRecord.where(user_id: @user).order(created_at: :desc)
  end

  def edit
  	@user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    user.update(user_params)
    redirect_to user_path(current_user)
  end

  def destroy
    user = User.find(current_user.id)
    user.destroy
    redirect_to root_path
  end

  def withdraw
  end

  def followed
    @users = current_user.followeds
  end

  def follower
    @users = current_user.followers
   end


  private

  def user_params
    params.require(:user).permit(:name, :pet_name, :profile_image, :intoroduction, :user_status)
  end
end