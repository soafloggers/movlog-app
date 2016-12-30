# frozen_string_literal: true

# Gets list of all movies from API
class FindMoviesFromApi
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_get_movie
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

  register :call_api_to_get_movie, lambda { |title|
    begin
      results = HTTP.get("#{MovlogApp.config.MOVLOG_API}/movie?search=#{title.gsub(' ', '+')}/")
      data = JSON.parse(results.body.to_s)
      # movies = MoviesSearchResultsRepresenter.new(MoviesSearchResults.new).from_json(data['movies'])
      channel_id = data['channel_id']
      Right(channel_id)
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }
end
