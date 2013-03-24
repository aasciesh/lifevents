class FriendshipsController < ApplicationController
	before_filter :signed_in_user
	before_filter :check_if_can_be_created, only: [:create]
	before_filter :check_right_user, only: [:update]

	def create
		@friendship = current_user.friendships.build(friend_id: params[:id])
		@friendship.status = 0
		if @friendship.save
			flash[:notice]= "Friend request sent."
			redirect_to user_path(params[:id])
		else
			flash[:notice]= "Friend request couldn't be sent."
			redirect_to user_path(params[:id])
		end
	end

	def update
		@inverse_friendship = current_user.inverse_friendships.find_by_user_id(params[:id])
		if @inverse_friendship.update_attribute(:status, 1 )
			flash[:notice] = "friend request accepted."
			redirect_to user_path(params[:id])
		else
			flash[:notice] = "Couldn't accept."
			redirect_to user_path(params[:id])
		end
	end

	def destroy
		@friendship = current_user.friendships.find_by_friend_id(params[:id])
		@inverse_friendship = current_user.inverse_friendships.find_by_user_id(params[:id])
		if !@friendship.nil? && @inverse_friendship.nil?
			if @friendship.destroy
				flash[:notice] = "Unfriended successfully."
				redirect_to user_path(params[:id])
			else
				flash[:notice] = "Couldn't unfriend."
				redirect_to user_path(params[:id])
			end
		elsif @friendship.nil? && !@inverse_friendship.nil?
			if @inverse_friendship.destroy
				flash[:notice] = "Unfriended successfully."
				redirect_to user_path(params[:id])
			else
				flash[:notice] = "Couldn't unfriend."
				redirect_to user_path(params[:id])
			end
		end
	end

	private
	def check_if_can_be_created
		# check if friendship relation already exists or the person, user trying to be friend with is himself or non-existant
		if !!current_user.inverse_friendships.find_by_user_id(params[:id]) || !!current_user.friendships.find_by_friend_id(params[:id]) || (current_user.id == params[:id]) || !User.find(params[:id])
			redirect_to root_path
			flash[:notice]= "This friendship cannot be created."
		end
	end

	def check_right_user
		#if friendship is tried to 'update as accepted' by the same person who sent request
		unless !!current_user.inverse_friendships.find_by_user_id(params[:id])
			redirect_to root_path
			flash[:notice] = "You dont't know what you are trying to do. Do you?."
		end
	end
end
