# frozen_string_literal: true
require_relative 'location'

class MovieDetailsView
  SHORT_STR_SIZE = 80
  IMDB_URL = 'http://www.imdb.com/title/'

  attr_reader :movie, :locations, :movie_url, :origin_airports

  def initialize(moive_details, origin_airports)
    @movie = moive_details.movie
    @movie_url = IMDB_URL+moive_details.movie.imdb_id
    @locations = format_all_locations(moive_details.locations)
    @origin_airports = format_all_airports(origin_airports)
  end

  private

  def format_all_locations(locations)
    locations&.map do |location|
      formatted_location(location)
    end
  end

  def formatted_location(location)
    LocationView.new(
      id = location.id,
      movie_id = location.movie_id,
      name = location.name
    )
  end

  def format_all_airports(airports)
    airports&.map do |airport|
      formatted_airport(airport)
    end
  end

  def formatted_airport(airport)
    AirportView.new(
      name = airport['name'],
      lat = airport['lat'],
      lng = airport['lng'],
      country_code = airport['country_code']
    )
  end
end
