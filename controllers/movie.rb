# frozen_string_literal: true

# MovlogAPP web service
class MovlogApp < Sinatra::Base
  get "/?" do
    slim :movie
  end

  get "/movie/?" do
    movie_request = MovieRequest.call(params)
    results = FindMoviesFromApi.call(movie_request)
    if results.success?
      @api_server = MovlogApp.config.API_SERVER
      @data = results.value
    else
      flash[:error] = 'Could not find movie'
    end
    slim :movie
  end

  get "/movie/table?" do
    movie_request = MovieRequest.call(params)
    results = FindMoviesFromApi.call(movie_request)
    if results.success?
      @api_server = MovlogApp.config.API_SERVER
      @data = results.value
    else
      flash[:error] = 'Could not find movie'
    end
    slim :movies_table
  end

  get "/movie/:title/?" do
    airports = Concurrent::Promise.execute {
      JSON.parse(FuzzySearchAirports.call(LocationRequest.call(params)).value)
    }
    movie_details = GetMovieDetails.call(params)
    if movie_details.success?
      @movie_details = MovieDetailsView.new(movie_details.value, airports.value)
      slim :movie_details
    else
      flash[:error] = 'Could not find that movie -- we are investigating!'
      redirect '/'
    end
  end
end
