# frozen_string_literal: true
require 'sinatra'
require 'slim'
require 'econfig'
require 'movlog'

require_relative 'base'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
