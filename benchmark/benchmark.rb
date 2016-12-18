require './init.rb'
require 'benchmark'

print '# APP, No Concurrency:   '
puts Benchmark.measure {
  5.times {
    HTTP.post("https://movlog.herokuapp.com/movie?title=Hobbits")
  }
}.real

print '# APP, With Concurrency: '
puts Benchmark.measure {
  5.times {
    Concurrent::Promise.execute {
      HTTP.post("https://movlog.herokuapp.com/movie?title=Hobbits")
    }
  }
}.real
