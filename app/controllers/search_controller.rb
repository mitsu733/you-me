class SearchController < ApplicationController
	def search
		# @wordsはapplication_controllerで定義
		@words = @search.result(distinct: true)
	end
end
