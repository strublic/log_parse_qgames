module LogParser
  class Accumulator
    attr_accessor :name, :total_kills, :players, :kills, :get_players

    def initialize
      @name = ""
      @total_kills = 0
      @players = 0
      @kills = {}
      @get_players = {}
    end

    def add(entry)
      self.name = entry.name
      self.total_kills = entry.get_kills.count
      self.get_players = entry.get_players
      self.players = self.get_players.map(&:name)

      self.get_players.each do |player|
        player_kills = entry.get_kills.select{|kill| kill.id_killer == player.id}
        self.kills[player.name] = player_kills.count
      end
    end
  end
end