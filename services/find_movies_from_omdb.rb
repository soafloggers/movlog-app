# frozen_string_literal: true

# Gets list of all movies from API
class FindMoviesFromOMDB
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request, lambda { |movie_request|
    if movie_request.success?
      Right(movie_request[:title])
    else
      message = ErrorFlattener.new(
        ValidationError.new(movie_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_load_movie, lambda { |title|
    begin
      Right(HTTP.post("#{MovlogApp.config.MOVLOG_API}/movie",
                      json: { url: get_url(title) }))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    if http_result.status.code == 200
      Right(MoviesSearchResultsRepresenter.new(MoviesSearchResults.new).from_json(http_result.body.to_s))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data.to_json)
      ).to_s
      Left(Error.new(message))
    end
  }

  def self.call(movie_request)
    Dry.Transaction(container: self) do
      step :validate_request
      step :call_api_to_load_movie
      step :return_api_result
    end.call(movie_request)
  end

  private_class_method

  def self.get_url(title)
    "http://www.omdbapi.com?t=#{title.gsub(/ /, '+')}&y=&plot=short&r=json"
  end
end
