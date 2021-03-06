require 'rubygems'
require 'nokogiri'

module PAXArcadiaTracker
  class DataLogger
    def start_logging
      @last_table = []
      Thread.new do
        loop do
          next_run_time = self.up_to_nearest_5(Time.now.to_i)
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
        puts "Opening url"
        uri = URI('https://secure.runescape.com/m=hiscore_oldschool/overall.ws')
        page = Net::HTTP.get(uri)
        parsed_page = Nokogiri::HTML(page)
        table = parsed_page.css("tbody tr.personal-hiscores__row")
        table.each do |player|
          string_player = player.text.tr("\n", "")
          #temp_player = Player.new
          #temp_player.time_completed = Time.now
          #temp_player.time_taken = player.css('td')[3].text.delete(" \n")
          #temp_player.username = player.css('td')[1].css('a').text.delete(" \n")
          #current_table.insert(temp_player)
          current_table << string_player
          unless @last_table.include? string_player
            new_player = Player.new
            new_player.time_completed = Time.now
            #new_player.time_taken = player.css('td')[3].text.delete(",")
            new_player.time_taken = player.css('td')[3].text.delete(",").delete("\n").to_i % 604800
            new_player.username = player.css('td')[1].css('a').text.delete(" \n")
            unless Player.find_by(time_taken: new_player.time_taken, username: new_player.username)
              new_player.save
            end
          end
        end
        #Reset last to current if there were changes
        @last_table = current_table
      end
    end

    def up_to_nearest_5(n)
      increment = 50
      rounded = n - (n % increment) + increment
      return rounded
    end
  end
end