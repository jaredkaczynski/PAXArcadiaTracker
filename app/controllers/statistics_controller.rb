class StatisticsController < ApplicationController
  def home
    unsorted = Player.all
    @players = unsorted.sort_by &:time_taken
  end

  def charts
    # How to make the data I want
    # Get all players sorted by time completed
    # keep lowest time taken in var and iterate storing new lowest in a list, return this list
    sorted = Player.order('time_completed')
    lowest_time = 2147483646
    best_times = []
    data_builder = ""
    sorted.each do |p|
      if(p.time_taken < lowest_time)
        lowest_time = p.time_taken
        best_times << p
        data_builder << "{ x: " + (p.time_completed.to_i%604800/3600).to_s + ", y: " + (p.time_taken/3600).to_s + "},"
      end
    end
    @data = data_builder
  end

  helper_method :formatted_duration

  def formatted_duration total_seconds
    hours = total_seconds / (60 * 60)
    minutes = (total_seconds / 60) % 60
    seconds = total_seconds % 60

    "#{ hours } h #{ minutes } m #{ seconds } s"
  end

end
