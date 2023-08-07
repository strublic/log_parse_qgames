module LogParser
  class Accumulator
    attr_accessor :name, :total_kills, :players, :kills, :get_players

    def initialize
      @name = ""
      @total_kills = 0
      @players = 0
      @kills = Hash.new(0)
      @get_players = {}
    end

    def add(entry)
      self.name = entry.name
      self.total_kills = entry.get_kills.count
      self.get_players = entry.get_players
      self.players = self.get_players.select{|p| p.id != "1022"}.map(&:name)

      self.get_players.each do |killer|
        kills_by_player = entry.get_kills.select{|kill| kill.id_killer == killer.id}
        
        if killer.id == "1022" 
          #removes kills from player that died by world
          kills_by_player.each do |kp|
            player_died = self.get_players.find{|p| p.id == kp.id_killed}
            self.kills[player_died.name] -= 1
          end
        else
            self.kills[killer.name] += kills_by_player.count
        end
      end
    end
  end
end