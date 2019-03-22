class StatisticsController < ApplicationController
  def show
    @players = Player.all
  end
end
