class EventjoinsController < ApplicationController
before_filter :signed_in_user


	def create
		@eventjoin = current_user.eventjoins.build(joinedevent_id: params[:event_id])
		if @eventjoin.save
			flash[:notice]= "You have joined."
			respond_to do |format|
		        format.html { redirect_to event_path(params[:event_id]) }
		        format.js { render json: {message: 'success'} }
		     end
			
		else
			flash[:notice]= "You could not join."
			respond_to do |format|
		        format.html { redirect_to event_path(params[:event_id]) }
		        format.js { render json: {message: 'failed'} }
		     end
		end
	end

	def destroy
		@eventjoin = current_user.eventjoins.find_by_joinedevent_id(params[:id])
		if @eventjoin.destroy
			flash[:notice]= "Unjoined."
			respond_to do |format|
		        format.html { redirect_to event_path(params[:id]) }
		        format.js { render json: {message: 'success'} }
		     end
		else
			flash[:notice]= "Something went wrong, unsuccessful."
			respond_to do |format|
		        format.html { redirect_to event_path(params[:id]) }
		        format.js { render json: {message: 'failed'} }
		     end
		end
	end

	
end