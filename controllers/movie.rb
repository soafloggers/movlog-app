# frozen_string_literal: true

# MovlogAPP web service
class MovlogApp < Sinatra::Base
  get "/?" do
    @not_found = params[:not_found]
    @data = params[:ch]
    @api_server = MovlogApp.config.API_SERVER
    slim :movie
  end

  get "/movie/?" do
    movie_request = MovieRequest.call(params)
    results = FindMoviesFromApi.call(movie_request)
    if results.success? && results.value.key?(:channel_id)
      @data = results.value[:channel_id]
      redirect "/?title=#{params[:title]}&ch=#{@data}#search"
    else
      redirect "/movie/table?title=#{params[:title]}"
    end
  end

  get "/movie/table?" do
    movie_request = MovieRequest.call(params)
    results = FindMoviesFromApi.call(movie_request)
    if results.success? && results.value[:movies].movies&.length != 0
      @data = results.value[:movies]
      slim :movies_table
    else
      redirect '/?not_found=1&#search'
    end
  end

  get "/movie/:title/?" do
    airports = Concurrent::Promise.execute {
      JSON.parse(FuzzySearchAirports.call(LocationRequest.call(params)).value)
    }
    movie_details = GetMovieDetails.call(params)
    if movie_details.success?
      @movie_details = MovieDetailsView.new(movie_details.value, airports.value)
      slim :movie_details
    end
  end
end
