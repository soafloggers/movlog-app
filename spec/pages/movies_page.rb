# frozen_string_literal: true

# Page object for all movies view (homepage)
class MoviesPage
  include PageObject

  page_url 'http://localhost:9000/'

  h1(:heading)
  button(:search_movie, id: 'movie_search_submit')
  table(:movies_table, id: 'movies_table')
  indexed_property(
    :movies,
    [
      [:a, :link, { id: 'movie[%s].link' }]
    ]
  )

  def movies_count
    browser.trs(class: 'movies_row').count
  end

  def first_row
    movies[0]
  end

  def last_row
    movies[movies_rows_count - 1] # zero index
  end

  def movies_rows_count
    movies_table_element.rows - 1 # without header
  end
end
