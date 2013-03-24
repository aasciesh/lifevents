
module UsersHelper
	def user_location
		@location = request.location
		user_channel = @location.city
		@location
	end

	def user_channel=(channel)
		@user_channel= channel
	end

	def user_channel
		@user_channel ||= request.location.city
	end
end
