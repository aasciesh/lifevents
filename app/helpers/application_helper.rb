module ApplicationHelper
	def user_location
		@location = request.location
	end
end
