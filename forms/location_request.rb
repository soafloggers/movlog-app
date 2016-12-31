# frozen_string_literal: true

LocationRequest = Dry::Validation.Form do
  required(:location).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/location_request.yml')
  end
end
