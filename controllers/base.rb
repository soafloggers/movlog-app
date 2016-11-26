require 'sinatra'
require 'econfig'

#configure based on environment
class MovlogApp < Sinatra::Base
  extend Econfig::Shortcut

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
    Skyscanner::SkyscannerApi.config.update(api_key: config.SKY_API_KEY)
    Airbnb::AirbnbApi.config.update(client_id: config.AIRBNB_CLIENT_ID)
    Geonames::GeonamesApi.config.update(username: config.GEONAMES_USERNAME)
  end

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  after do
    content_type 'text/html'
  end
end
