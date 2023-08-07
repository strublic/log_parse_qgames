module LogParser
  class Tokenizer
    def initialize(lines)
      @lines = lines
    end

    def entries
      i = 0
      games = []
      currentGame = nil

      @lines.each do |line|
        if line.include?("InitGame")
          i+=1
          currentGame = Game.new("Game: ##{i}")
          player = EntryPlayer.new("1022", "<world>")
          currentGame.add_player(player)
        end

        if !currentGame.nil? && !line.include?("InitGame")
          if line.include?("ClientUserinfoChanged")
            player = EntryPlayer.new(line.split[2],line.split('\\')[1])
            currentGame.add_player(player)
          end

          if line.include?("Kill")
            kill = EntryKill.new(*line.split[2..3])
            currentGame.add_kill(kill)
          end

          if line.include?("ShutdownGame")
            games.push(currentGame) 
          end
        end
      end
      
      games
    end
  end
end