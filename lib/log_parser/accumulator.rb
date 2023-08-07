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
      self.players = self.get_players.select{|p| p.id != "1022"}.map(&:name)

      self.get_players.each do |killer|
        kills_by_player = entry.get_kills.select{|kill| kill.id_killer == killer.id}
        
        if killer.id == "1022" 
          #removes death from played that died
          #players died by world
          kills_by_player.each do |kp|
            player_died = self.get_players.find{|p| p.id == kp.id_killed}
            counter_player_killed = kills_by_player.select{|pk| pk.id_killed == player_died.id}
            self.kills[player_died.name] = self.kills[player_died.name] || -counter_player_killed.count
          end
        else
          if self.kills[killer.name].nil?
            self.kills[killer.name] = kills_by_player.count
          else
            self.kills[killer.name] += kills_by_player.count
          end
        end
      end
    end
  end
end