# frozen_string_literal: true

# MovlogAPP web service
class MovlogApp < Sinatra::Base
  get "/?" do
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

  post "/movie/?" do
    url_request = UrlRequest.call(params)
    result = FindMovies.call(url_request)
    if result.success?
      @movie = result.value
    else
      flash[:error] = result.value.message
    end

    # redirect '/'
    slim :movie
  end
end
