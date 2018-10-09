require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  
  handler do |job|
    puts "Running #{job}"
  end

  every(1.day, 'synchronize', at: '10:00', tz: 'UTC') { 
    `rake synchronize`
  }
end