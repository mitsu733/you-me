class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :reset_path_info

	# 検索機能
	before_action :set_search

	def set_search
		if params[:q] == nil
			@search = PetRecord.ransack(params[:q])
		else
			search_params = params[:q][:user_name_or_user_pet_name_or_user_intoroduction_or_body_cont_any]
			if params[:q][:s].nil?
				params[:q][:user_name_or_user_pet_name_or_user_intoroduction_or_body_cont_any] = params[:q][:user_name_or_user_pet_name_or_user_intoroduction_or_body_cont_any].split(/[\p{blank}\s]+/)
			end
	  		@search = PetRecord.ransack(params[:q])
	  	end
	end

	protected

	# サインイン時入力する項目
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :pet_name, :email])
	end

	private

	# 以下ログイン、ログアウト時の遷移先
	def after_sign_in_path_for(resource)
		if session[:is_last_visit_page_pets_records]
		  return pet_records_path
		else
		  return user_path(current_user.id)
		end
	end

	def after_sign_out_path_for(resource)
		root_path
	end

	def reset_path_info
		session.delete(:is_last_visit_page_pets_records)
	end
end