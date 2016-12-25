# frozen_string_literal: true

Movie = Struct.new :imdb_id, :title, :poster, :rating, :awards,
                   :runtime, :director, :actors, :plot
