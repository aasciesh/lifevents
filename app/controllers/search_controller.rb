class SearchController < ApplicationController
	def index
		@users = User.search params
		@events = Event.search(params, user_location)

		raise @events.to_json

		respond_to do |format|
			format.html 
			format.js { render @users.to_json }
		end
	end
end
