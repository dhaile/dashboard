module AdminHelper
class Dashboard

      
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#           City of Los Angeles
#
#
#          This is a protype and not rady for production
#
#
#
#
#
#
#
#
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

require 'csv'
require 'soda/client'
# Initializing the SODA API
client = SODA::Client.new({:domain => 'data.lacity.org', :app_token => 'klRm5Wi5CpoRFhLpFJbwfXbn7'})
response = client.get("6rrh-rzua")

CSV.open("/home/dawit/data.csv", "wb") do |csv|

	0.upto(999){|i|
		unless response[i].to_hash["location_1"].nil?  
			coordinate = response[i].to_hash["location_1"].with_indifferent_access.except(:needs_recoding)
			# start Generateing a CSV file
			csv << [coordinate["longitude"],  coordinate["latitude"]]
        end

	}
end


    end 
end
