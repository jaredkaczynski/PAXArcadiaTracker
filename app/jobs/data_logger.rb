require 'rubygems'
require 'nokogiri'

module PAXArcadiaTracker
  class DataLogger
    @last_table = []

    def start_logging
      Thread.new do
        next_run_time = self.up_to_nearest_5(Time.now.to_i)
        loop do
          if (sleep_time = (next_run_time - Time.now.to_i)) > 0
            sleep(sleep_time)
          end
          self.get_stats
        end
      end
    end

    def get_stats
      Thread.new do
        current_table = []
        uri = URI('https://secure.runescape.com/m=hiscore_oldschool/overall.ws')
        page = Net::HTTP.get(uri)
        parsed_page = Nokogiri::HTML(page)
        table = parsed_page.css("div#contentHiscores tbody tr")
        table.each do |player|
            #temp_player = Player.new
            #temp_player.time_completed = Time.now
            #temp_player.time_taken = player.css('td')[3].text.delete(" \n")
            #temp_player.username = player.css('td')[1].css('a').text.delete(" \n")
            #current_table.insert(temp_player)
            current_table.insert(player)
            unless @last_table.include? player
              new_player = Player.new
              new_player.time_completed = Time.now
              new_player.time_taken = player.css('td')[3].text.delete(" \n")
              new_player.username = player.css('td')[1].css('a').text.delete(" \n")
            end
        end
        #Reset last to current if there were changes
        @last_table = current_table
      end
    end

    def up_to_nearest_5(n)
      return n if n % 50 == 0
      rounded = n.round(-1)
      rounded > n ? rounded : rounded + 5
    end
  end
end