class RecordCommentsController < ApplicationController
   before_action :authenticate_user!

  def index
    @record_comments = current_user.comments.group(:id)
  end

  def create
    pet_record = PetRecord.find(params[:record_comment][:pet_record_id])
    @record_comment = current_user.record_comments.new(record_comment_params)
    @record_comment.pet_record_id = pet_record.id
    if  @record_comment.save
        redirect_to pet_record_path(pet_record.id)
    else
      @pet_record = pet_record
      @like_users = @pet_record.like_users
      render "pet_records/show"
    end
  end

  def destroy
    record_comment = RecordComment.find(params[:id])
    pet_record = record_comment.pet_record
    record_comment.destroy
    redirect_to pet_record_path(pet_record.id)
  end


  private

    def record_comment_params
      params.require(:record_comment).permit(:comment)
    end
end
