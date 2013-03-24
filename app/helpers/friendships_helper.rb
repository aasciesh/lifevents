module FriendshipsHelper
	def is_friend_already?(user_id)
		friendship = current_user.friendships.find_by_friend_id(user_id) || current_user.inverse_friendships.find_by_user_id(user_id)
		if !friendship.nil?
			if friendship.status == 1
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def has_requested_friendship?(user_id)
		friendship = current_user.inverse_friendships.find_by_user_id(user_id)
		if !friendship.nil? 
			if friendship.status == 0
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def  has_to_accept_friendship?(user_id)
		friendship = current_user.friendships.find_by_friend_id(user_id)
		if !friendship.nil? 
			if friendship.status == 0
				return true
			else
				return false
			end
		else
			return false
		end
	end


end
