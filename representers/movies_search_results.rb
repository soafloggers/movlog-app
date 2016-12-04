# frozen_string_literal: true
require_relative 'movie'

class MoviesSearchResultsRepresenter < Roar::Decorator
  include Roar::JSON

  property :title
  collection :movies, extend: MovieRepresenter, class: Movie
end
