module EventsHelper
	def faye_transmit(liveItem)
		area = Geocoder.search("#{liveItem["latitude"]}, #{liveItem["longitude"]}")
		channel = area[0].city

		message = {:channel => "/helsinki", :data => liveItem.to_json}
		if Rails.env.development?
    		uri = URI.parse("http://localhost:9292/faye")
    	else
    		uri = URI.parse("http://198.211.126.212:9292/faye")
    	end
    	
    	Net::HTTP.post_form(uri, :message => message.to_json)
	end

	
end