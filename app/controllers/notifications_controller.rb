class NotificationsController < ApplicationController
  def index
  	@notifications = current_user.inverse_friendships.where(status: 0)
  end
end
