require 'sinatra'
require 'adsense-info'

raise "GOOGLE_USERNAME must be set in the environment" unless ENV.has_key?( 'GOOGLE_USERNAME' )
raise "GOOGLE_PASSWORD must be set in the environment" unless ENV.has_key?( 'GOOGLE_PASSWORD' )

ADSENSE = Adsense::Info.new( ENV['GOOGLE_USERNAME'], ENV['GOOGLE_PASSWORD'] )

get '/' do
  ADSENSE.update_values!
  response['Cache-Control'] = 'public, max-age=60' # Cache for one minute to prevent slamming adsense with requests
  @today_so_far = ADSENSE.today_so_far
  @yesterday = ADSENSE.yesterday
  @this_month_so_far = ADSENSE.this_month_so_far
  @last_month = ADSENSE.last_month
  erb :adsense_info
end
