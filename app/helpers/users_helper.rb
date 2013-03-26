
module UsersHelper
	def user_location
		@location = request.location
		user_channel = @location.country
		@location
	end

	def user_channel=(channel)
		@user_channel= channel
	end

	def user_channel
		@user_channel ||= request.location.country
	end
end
