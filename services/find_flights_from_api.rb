# frozen_string_literal: true

# Get rooms info from API
class FindRoomsFromApi
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request, lambda { |flight_request|
    if flight_request.success?
      Right(flight_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(room_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_find_flights, lambda { |params|
    begin
      Right(HTTP.get("#{MovlogApp.config.MOVLOG_API}/flight/#{params[:origin]}/#{params[:destination]}"))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_flights_result, lambda { |http_result|
    if http_result.status.code == 200
      Right(http_result.body.to_s)
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(input.to_json.to_s)
      ).to_s
      Left(Error.new(message))
    end
  }

  def self.call(room_request)
    Dry.Transaction(container: self) do
      step :validate_request
      step :call_api_to_find_flights
      step :return_flights_result
    end.call(room_request)
  end
end