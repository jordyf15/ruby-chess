require_relative "board"
require_relative "game"
def main
  puts "Welcome to Chess"
  puts "Each turn will be played in 2 different steps"
  puts "1. Choose your piece that have legal moves in that turn"
  puts "2. Choose the available legal moves to move your piece"
  puts "The inputs will be the coordination such as A5 and H3"
  puts "\n\n\n"
  quit = false
  until quit == true
    puts "To begin please choose one of the following options"
    puts "1. Play a new 1-player game againt a computer"
    puts "2. Play a new 2-player game"
    puts "3. Load a saved game"
    puts "4. Quit"
    gameplay_option = gets.chomp.to_i
    until gameplay_option >= 1 && gameplay_option <= 4
      puts "Please input between 1 - 4"
      gameplay_option = gets.chomp.to_i
    end
    case gameplay_option
    when 1
      game = Game.new 1
      game.play
    when 2
      game = Game.new 2
      game.play
    when 3
      game = load_game
      game.play
    when 4
      quit = true
    end
  end
  puts "Thank you for playing chess, have a nice day.."
end

def load_game
  puts "Here are the available saved games: "
  files = Dir.glob('saves/*').map { |file_path| file_path[6..-1] }
  files.each_with_index { |file, index| puts "#{index + 1}. #{file}" }
  print "Please choose the one you want to load (1-#{files.size}): "
  choice = gets.chomp.to_i
  until choice >= 1 && choice <= files.size
    print "File doesn't exist. Please choose an existing file: ".red
    choice = gets.chomp.to_i
  end
  serialized_game_data = File.read("saves/#{files[choice - 1]}")
  game = YAML.load(serialized_game_data)
  puts "\n\n"
  puts "#{files[choice - 1]} loaded"
  game
end

main