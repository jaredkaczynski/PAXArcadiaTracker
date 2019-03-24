class StatisticsController < ApplicationController
  def get
    @players = Player.all
  end

  helper_method :formatted_duration

  def formatted_duration total_seconds
    hours = total_seconds / (60 * 60)
    minutes = (total_seconds / 60) % 60
    seconds = total_seconds % 60

    "#{ hours } h #{ minutes } m #{ seconds } s"
  end

end
