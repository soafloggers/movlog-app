# frozen_string_literal: true
require_relative 'location'

class MovieDetailsView
  SHORT_STR_SIZE = 80
  MOVIE_URL_PREFIX = 'http://www.imdb.com/title/'

  attr_reader :movie_title, :movie_url, :locations

  def initialize(moive_details)
    @locations = format_all_locations(moive_details.locations)
  end

  private

  def format_all_locations(locations)
    new_postings = locations&.map do |location|
      formatted_posting(location)
    end
  end

  def formatted_location(location)
    LocationView.new(
      id = location.id,
      movie_id = location.movie_id,
      name = location.name,
      lat = location.lat,
      lng = location.lng
    )
  end

  def original_attachment_url(attachment_url)
    return unless attachment_url
    CGI.unescape(attachment_url.gsub(FB_ATTACHED_URL_PREFIX, ''))
  end

  def shortened(str, size)
    return nil unless str
    str.length < size ? str : str[0..size].gsub(/\s\w+\s*$/,'...')
  end
end
