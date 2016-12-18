# frozen_string_literal: true

# MovlogAPP web service
class MovlogApp < Sinatra::Base
  get "/?" do
    slim :movie
  end

  get "/movie/?" do
    movie_request = MovieRequest.call(params)
    results = FindMoviesFromDB.call(movie_request)
    if results.success? && results.value.movies&.count != 0
      @data = results.value
    else
      result = FindMoviesFromOMDB.call(movie_request)
      if result.success?
        @data = result.value && results.value.movies&.count != 0
      else
        flash[:error] = 'Could not find movie'
      end
    end
    slim :movie
  end

  get "/movie/:title/?" do
    movie_details = GetMovieDetails.call(params)
    if movie_details.success?
      movie_locations = movie_details.value
      @movie_details = MovieDetailsView.new(movie_locations)
      slim :movie_details
    else
      flash[:error] = 'Could not find that movie -- we are investigating!'
      redirect '/'
    end
  end
end
