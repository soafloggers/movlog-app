# frozen_string_literal: true

# Get rooms info from API
class FuzzySearchAirports
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(room_request)
    Dry.Transaction(container: self) do
      step :validate_request
      step :call_api_to_find_airports
      step :return_airports_result
    end.call(room_request)
  end

  register :validate_request, lambda { |airport_request|
    if airport_request.success?
      Right(airport_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(airport_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_find_airports, lambda { |params|
    begin
      puts airports_url(params[:location])
      Right(HTTP.get(airports_url(params[:location])))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_airports_result, lambda { |http_result|
    puts http_result.body.to_s
    if http_result.status.code == 200
      Right(http_result.body.to_s)
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(http_result.body.to_s)
      ).to_s
      Left(Error.new(message))
    end
  }

  private_class_method

  def self.airports_url(location)
    "#{MovlogApp.config.MOVLOG_API}/airports/fuzzysearch/#{location}"
  end
end
