# frozen_string_literal: true

# Gets list of all movies from API
class FindMoviesFromOMDB
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_load_movie
      step :return_api_result
    end.call(url_request)
  end

  register :validate_url_request, lambda { |url_request|
    if url_request.success?
      Right(url_request[:title])
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
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
    data = JSON.parse(http_result.body)
    if http_result.status == 200
      result = { title: data[:title], movies: [data] }
      Right(MoviesSearchResultsRepresenter.new(MoviesSearchResults.new).from_json(result.to_json))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }

  private_class_method

  def self.get_url(title)
    "http://www.omdbapi.com?t=#{title.gsub(/ /, '+')}&y=&plot=short&r=json"
  end
end
