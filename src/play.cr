require "./rosegold"

def show_help
  puts "Rosegold v#{Rosegold::VERSION}"
  puts "~"*20
  puts "\\help - This help screen"
  puts "\\position - Displays the current coordinates of the player"
end

Rosegold::Client.new("test.civmc.net", 25566).start do |bot|
  show_help

  spawn do
    bot.on Rosegold::Clientbound::Teams do |packet|
      Log.info { "Teams: #{packet}" }
    end

    bot.on Rosegold::Clientbound::ScoreboardObjective do |packet|
      Log.info { "ScoreboardObjective[name]: #{packet.objective_name}" }
      Log.info { "ScoreboardObjective[value]: #{packet.objective_value}" }
    end

    update_score_count = 0
    bot.on Rosegold::Clientbound::UpdateScore do |packet|
      Log.info { "UpdateScore[name]: #{packet.entity_name}" }
      Log.info { "UpdateScore[called_count]: #{update_score_count += 1}" }
    end
  end

  loop do
    gets.try do |input|
      next if input.empty?

      if input.starts_with? "\\"
        command = input.split(" ")
        case command.first
        when "\\help"
          show_help
        when "\\position"
          puts bot.player.feet
        when "\\pitch"
          if command.size > 1
            bot.pitch = command[1].to_f
          else
            puts bot.pitch
          end
        when "\\yaw"
          if command.size > 1
            bot.yaw = command[1].to_f
          else
            puts bot.yaw
          end
        when "\\move"
          bot.move_to command[1].to_f, command[2].to_f, command[3].to_f
        when "\\jump"
          bot.jump
        when "\\debug"
          Log.setup :debug
        when "\\trace"
          Log.setup :trace
        end

        next
      end

      bot.chat input
    end
  end
end
