class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.where(user_status: 0)
  end

  def show
    user = User.find(params[:id])
    if user.user_status == "公開" || user.id == current_user.id
      @user = user
      @pet_records = PetRecord.where(user_id: @user).order(created_at: :desc)
    else
      redirect_back(fallback_location: root_url)
    end
  end

  def edit
    user = User.find(params[:id])
    if user.id == current_user.id
  	  @user = user
    else
      redirect_back(fallback_location: root_url)
    end
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
    user = User.find(params[:id])
    if user.user_status == "公開" || user.id == current_user.id
      @users = user.followeds
    else
      redirect_back(fallback_location: root_url)
    end
  end

  def follower
    user = User.find(params[:id])
    if user.user_status == "公開" || user.id == current_user.id
      @users = user.followers
    else
      redirect_back(fallback_location: root_url)
    end
   end


  private

  def user_params
    params.require(:user).permit(:name, :pet_name, :profile_image, :intoroduction, :user_status)
  end
end