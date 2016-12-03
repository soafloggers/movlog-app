# frozen_string_literal: true

# MovlogAPI web service
class MovlogApp < Sinatra::Base
  get "/?" do
    slim :movie
  end

  get "/result/?" do
    slim :search_result
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
