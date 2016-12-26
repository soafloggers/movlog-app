# frozen_string_literal: true
require_relative 'location'

# Represents overall group information for JSON API output
class MovieDetailsRepresenter < Roar::Decorator
  include Roar::JSON

  property :movie, extend: MovieRepresenter, class: Movie
  collection :locations, extend: LocationRepresenter, class: Location
end
