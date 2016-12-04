# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Page elements' do
    it '(HAPPY) should see website features' do
      # GIVEN
      @browser.goto homepage
      @browser.title.must_include 'Movlog'
      @browser.h1.text.must_include 'Movlog'

      # THEN
      @browser.input(id: 'movie_title_input').visible?.must_equal true
      @browser.button(id: 'movie_search_submit').visible?.must_equal true
    end
  end

  describe 'Searching a movie' do
    it '(HAPPY) should be able to find movies' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # WHEN: input a valid movie title
      @browser.text_field(id: 'movie_title_input').set(HAPPY_MOVIE_TITLE)
      @browser.button(id: 'movie_search_submit').click

      # THEN: movies should be present on homepage
      movie_title_span = @browser.spans(class: 'movie_title').last
      movie_title_span.text.must_include 'Star'
    end
  end
end
