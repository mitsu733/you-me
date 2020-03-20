class PetRecordsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  skip_before_action :reset_path_info, only: [:index]

  def index
    session[:is_last_visit_page_pets_records] = true
    @pet_records = PetRecord.where(record_public: true).order(created_at: :desc).page(params[:page]).per(8)
  end

  def new
    @pet_record = PetRecord.new
  end

  def create
    @pet_record = PetRecord.new(pet_record_params)
    @pet_record.user = current_user
    if  @pet_record.save
        redirect_to @pet_record
    else
        @pet_record = PetRecord.new
        render "new"
    end
  end

  def show
    @pet_record = PetRecord.find(params[:id])
  end

  def edit
    @pet_record = PetRecord.find(params[:id])
  end

  def update
    @pet_record = PetRecord.find(params[:id])
    @pet_record.user = current_user
    if  @pet_record.update(pet_record_params)
        redirect_to pet_record_path(@pet_record)
    else
        @pet_record = PetRecord.find(params[:id])
        render "edit"
    end
  end

  def destroy
    @pet_record = PetRecord.find(params[:id])
    @pet_record.destroy
    redirect_to user_path(current_user)
  end

  def tag
     @tag = Tag.find(params[:tag_id])
     @tag_pet_records = @tag.record_tags
  end

  def infinite_scrolling
    @pet_records = PetRecord.where(record_public: true).order(created_at: :desc).page(params[:page]).per(8)
    if @pet_records.total_pages < params[:page].to_i
      @next_page = "last"
      else
      @next_page = params[:page].to_i + 1
    end
    respond_to do |format|
      format.js
    end
  end


  private

    def pet_record_params
      params.require(:pet_record).permit(:toilet, :water, :food, :energy, :record_image, :body, :record_public, :user_id, :tag_ids)
    end
end
