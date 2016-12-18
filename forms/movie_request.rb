# frozen_string_literal: true

MovieRequest = Dry::Validation.Form do
  required(:title).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/movie_request.yml')
  end
end
