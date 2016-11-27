# frozen_string_literal: true

# MovlogAPI web service
class MovlogApp < Sinatra::Base
  get "/?" do
    slim :movie
  end

  post "/movie/?" do
    url_request = UrlRequest.call(params)
    result = CreateNewMovie.call(url_request)
    if result.success?
      @movie = result.value
      flash[:notice] = 'Movie successfully added'
    else
      flash[:error] = result.value.message
    end

    # redirect '/'
    slim :movie
  end
end
