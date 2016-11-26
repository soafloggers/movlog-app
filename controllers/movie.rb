# frozen_string_literal: true

# MovlogAPI web service
class MovlogApp < Sinatra::Base
  get "/?" do
    "Welcome to MovlogApp!"
  end

  get "/home/?" do
    slim :movie
  end
end
