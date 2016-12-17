require './init.rb'
require 'benchmark'

puts Benchmark.measure {
  5.times {
    HTTP.post("http://localhost:9292/movie?title=Hobbits")
  }
}.real

puts Benchmark.measure {
  5.times {
    Concurrent::Promise.execute {
      HTTP.post("http://localhost:9292/movie?title=Hobbits")
    }
  }
}.real
