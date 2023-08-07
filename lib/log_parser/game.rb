class Game
  attr_accessor :name
  def initialize(name)
    @name = name
    @players = []
    @kills = []
  end

  def get_players
    return @players
  end

  def get_kills
    return @kills
  end

  def add_player(player)
    @players.push(player) unless @players.find{|p| p.id == player.id}
  end

  def add_kill(kill)
    @kills.push(kill)
  end
end