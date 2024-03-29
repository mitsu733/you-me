class UserRelationshipsController < ApplicationController
 before_action :authenticate_user!
  
  def create
  	follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_back(fallback_location: root_url)
  end

  def destroy
  	follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_url)
  end
end
