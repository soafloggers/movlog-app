# frozen_string_literal: true

RoomRequest = Dry::Validation.Form do
  required(:location).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/room_request.yml')
  end
end
