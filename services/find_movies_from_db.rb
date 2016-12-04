# frozen_string_literal: true

# Gets list of all movies from API
class FindMoviesFromDB
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    results = HTTP.get("#{MovlogApp.config.MOVLOG_API}/movie?search=#{params[:title]}/")
    Right(MoviesSearchResultsRepresenter.new(MoviesSearchResults.new).from_json(results.body.to_s))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
