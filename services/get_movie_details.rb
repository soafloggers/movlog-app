# frozen_string_literal: true

# Gets movie details from APIs
class GetMovieDetails
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    result = HTTP.get("#{MovlogApp.config.MOVLOG_API}/location/#{params[:title]}")
    puts "get location result: #{result.body}"
    Right(MovieDetailsRepresenter.new(MovieDetails.new)
                                 .from_json(result.body.to_s))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
