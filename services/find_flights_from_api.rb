# frozen_string_literal: true

# Get rooms info from API
class FindFlightsFromApi
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(room_request)
    Dry.Transaction(container: self) do
      step :validate_request
      step :call_api_to_find_flights
      step :return_flights_result
    end.call(room_request)
  end

  register :validate_request, lambda { |flight_request|
    if flight_request.success?
      Right(flight_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(flight_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_find_flights, lambda { |params|
    begin
      puts flights_url(params)
      Right(HTTP.get(flights_url(params)))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_flights_result, lambda { |http_result|
    if http_result.status.code == 200
      Right(http_result.body.to_s)
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(http_result.to_body)
      ).to_s
      Left(Error.new(message))
    end
  }

  private_class_method

  def self.flights_url(params)
    "#{MovlogApp.config.MOVLOG_API}/flights/#{params[:origin]}/#{params[:destination]}/anytime"
  end
end
