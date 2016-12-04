# frozen_string_literal: true

# Represents overall movie information for JSON API output
class LocationRepresenter < Roar::Decorator
  include Roar::JSON
  property :id
  property :movie_id
  property :name
  property :lat
  property :lng
end
