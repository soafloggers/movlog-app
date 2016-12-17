require './init.rb'
require 'benchmark'

puts Benchmark.measure {
  5.times {
    HTTP.post("https://movlog.herokuapp.com/movie?title=Hobbits")
  }
}.real

puts Benchmark.measure {
  5.times {
    Concurrent::Promise.execute {
      HTTP.post("https://movlog.herokuapp.com/movie?title=Hobbits")
    }
  }
}.real
