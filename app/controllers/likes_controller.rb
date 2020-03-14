class LikesController < ApplicationController
 before_action :authenticate_user!

  def index
    @like_pet_records = current_user.like_pet_records
  end

  def create
    @pet_record = PetRecord.find(params[:pet_record_id])
    like = current_user.likes.new(pet_record_id: @pet_record.id)
    like.save
  end

  def destroy
  	@pet_record = PetRecord.find(params[:pet_record_id])
    like = current_user.likes.find_by(pet_record_id: @pet_record.id)
    like.destroy
  end
end
