# frozen_string_literal: true
Dir.glob('./{config,controllers,views}/init.rb').each do |file|
  require file
end
