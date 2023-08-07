module LogParser
  class Formatter
    def initialize(aggregator_result)
      @aggregator_result = aggregator_result
    end

    def format
      <<~EOF
        \n##########################
        --| Quake log results |--
        ##########################\n
        #{show_games}

        Sum total kills: #{total_kills}
        \n##########################
        --| Log end |--
        ##########################\n
      EOF
    end

    private

    def show_games
      @aggregator_result.map do |k, game|
        <<~EOF
        ==============
        = #{game.name} =
        Total kills: #{game.total_kills}
        Players: #{game.players}
        Kills:
        #{kills_per_player(game).join(",\n")}
        ==============
        EOF
      end.join("\n")
    end

    def total_kills
      total = 0
      @aggregator_result.map do |game|
        total+= game[1].total_kills
      end

      total
    end

    def kills_per_player(game)
      game.kills.map do |key, value|
        " > #{key}: #{value}"
      end
    end
  end
end