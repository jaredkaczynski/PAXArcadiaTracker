require 'rubygems'
require 'nokogiri'

module PAXArcadiaTracker
  class DataLogger
    def start_logging
      Thread.new do
        next_run_time = self.up_to_nearest_5(Time.now)
        loop do
          sleep(next_run_time - Time.now)
          self.get_stats
        end
      end
    end

    def get_stats
      Thread.new do
        uri = URI('http://paxxp.com/leaderboard')
        page = Net::HTTP.get(uri)
      end
    end

    def up_to_nearest_5(n)
      return n if n % 5 == 0
      rounded = n.round(-1)
      rounded > n ? rounded : rounded + 5
    end
  end
end