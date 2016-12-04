# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'

require './init.rb'

HOST = 'http://localhost:9000/'

def homepage
  HOST
end

HAPPY_MOVIE_TITLE = 'star wars'
SAD_MOVIE_TITLE = 'sadmovie'
