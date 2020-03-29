class ApplicationController < ActionController::Base
	protect_from_forgery
	before_action :store_current_location, unless: :devise_or_infinite_scrolling_action?
	before_action :configure_permitted_parameters, if: :devise_controller?

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
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :pet_name, :email])
	end

	private

	# 以下ログイン、ログアウト時の遷移先
	def after_sign_in_path_for(resource)
	  return stored_location_for(resource) || pet_records_path
    end

	def after_sign_out_path_for(resource)
		root_path
	end


	def store_current_location
      store_location_for(:user, request.url)
    end

	def devise_or_infinite_scrolling_action?
	  devise_controller? || action_name == 'infinite_scrolling'
	end

end