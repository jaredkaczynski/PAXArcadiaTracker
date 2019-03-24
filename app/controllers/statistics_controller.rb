class StatisticsController < ApplicationController
  def get
    @players = Player.all
  end
end
