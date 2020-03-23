class SearchController < ApplicationController
	before_action :authenticate_user!
	def search
		# @wordsはapplication_controllerで定義
		@words = @search.result(distinct: true)
	end
end
