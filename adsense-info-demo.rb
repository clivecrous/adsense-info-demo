require 'sinatra'
require 'adsense-info'

$adsense = Adsense::Info.new( ENV['GOOGLE_USERNAME'], ENV['GOOGLE_PASSWORD'] )

get '/' do
  response['Cache-Control'] = 'public, max-age=60' # Cache for one minute to prevent slamming adsense with requests
  @today_so_far = $adsense.today_so_far
  erb :adsense_info
end