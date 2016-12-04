# frozen_string_literal: true

# MovlogAPI web service
class MovlogApp < Sinatra::Base
  get "/?" do
    slim :movie
  end

  get "/result/?" do
    slim :search_result
  end

  get "/movie/?" do
    results = FindMoviesFromDB.call(params)
    if results.success?
      @data = results.value
      puts @data
    else
      result = FindMoviesFromOMDB.call(params)
      if result.success?
        @data = result.value
      else
        flash[:error] = result.value.message
      end
      # flash[:error] = results.value.message
    end

    slim :movie
  end

  # get '/movie/?' do
  #   results = FindMoviesFromDB.call(params)
  #   if results.success?
  #     @data = results.value
  #   else
  #     flash[:error] = results.value.message
  #   end
  # end

  # post "/movie/?" do
  #   url_request = UrlRequest.call(params)
  #   result = FindMoviesFromOMDB.call(url_request)
  #   if result.success?
  #     @movie = result.value
  #   else
  #     flash[:error] = result.value.message
  #   end

    # redirect '/'
    # slim :movie
  # end
end
