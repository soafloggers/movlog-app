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
    include PageObject::PageFactory

    it '(HAPPY) should see website features' do
      visit MoviesPage do |page|
      # GIVEN
        page.heading.must_include 'Movlog'

        # THEN
        page.movie_input_element.visible?.must_equal true
        page.search_movie_element.visible?.must_equal true
      end
    end
  end

  describe 'Searching a movie' do
    include PageObject::PageFactory

    it '(HAPPY) should be able to find movies' do
      visit MoviesPage do |page|
        # WHEN: input a valid movie title
        page.movie_input = HAPPY_MOVIE_TITLE
        page.search_movie

        # THEN: movies should be present on homepage
        page.last_row.link_element.text.must_include 'Hobbits'
      end
    end
  end
end
