# frozen_string_literal: true

FlightRequest = Dry::Validation.Form do
  required(:origin).filled
  required(:destination).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/flight_request.yml')
  end
end
