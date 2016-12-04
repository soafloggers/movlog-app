# frozen_string_literal: true

UrlRequest = Dry::Validation.Form do
  required(:title).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/url_request.yml')
  end
end
