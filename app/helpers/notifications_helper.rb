module NotificationsHelper
	def no_of_notifications
		current_user.inverse_friendships.where(status: 0).count
	end
end
