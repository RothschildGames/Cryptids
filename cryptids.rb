Dir['./player/*.rb'].each {|file| require file }
Dir['./logic/*.rb'].each {|file| require file }
Dir['./lib/*.rb'].each {|file| require file }
require 'observer'
require './card'
require './race'
require './game'
require './logger'

NUMBER_OF_PLAYERS = 3
STARTING_ENERGY = 5
WINNING_ENERGY = 10
NUMBER_OF_GAMES = 10000
SHOULD_LOG = false

def run_single_game(options = {})
  options = {:starting_energy => STARTING_ENERGY, :winning_energy => WINNING_ENERGY, :number_of_players => NUMBER_OF_PLAYERS, :should_log => SHOULD_LOG}.merge(options)
  game = Game.new(options[:starting_energy], options[:winning_energy])

  GameLogger.new(game) if options[:should_log]

  #game.add_player Player::Basic.new('Test')
  game.add_player Player::Random.new(0)
  (options[:number_of_players] - 1).times do |t|
    game.add_player Player::Random.new(t + 1)
  end

  game.start_game

  while not game.game_ended? do
    game.turn
  end

  game
end

def run_multiple_game_for_options(options = {})
  options = {:number_of_games => NUMBER_OF_GAMES}.merge(options)
  options[:number_of_games].times.map { run_single_game(options) }
end

def run_multiple_games
  winners = []
  turns = []
  win_type = []
  games = run_multiple_game_for_options

  games.each do |result_game|
    winners << result_game.winners
    turns << result_game.turn_num
    win_type << result_game.win_type
  end

  average_turn = turns.reduce(:+).to_f / turns.length

  winners.flatten!
  victories = winners.inject({}) do |hash, player|
    hash[player.name] = 0 if hash[player.name].nil?
    hash[player.name] += 1
    hash
  end

  puts "Played #{games.length} games with #{NUMBER_OF_PLAYERS} players"
  puts "Game ended at turn #{average_turn} averagely"
  puts "Games mostly ended with a #{win_type.mode} (#{win_type.percent_of(win_type.mode)}%), then with #{win_type.mode_array[-2]} (#{win_type.percent_of(win_type.mode_array[-2])}%)"
  puts 'Victory count by players:'
  victories.sort.each do |victories|
    puts "\t#{victories[0]}\t#{victories[1]*100.0/games.length}% (#{victories[1]})"
  end
end


def run_multiple_options_games
  2.upto(7) do |number_of_players|
    5.upto(10) do |winning_energy|
      1.upto(winning_energy-1) do |starting_energy|
        games = run_multiple_game_for_options(:number_of_players => number_of_players, :winning_energy => winning_energy, :starting_energy => starting_energy)

        winners = []
        turns = []
        win_type = []

        games.each do |result_game|
          winners << result_game.winners
          turns << result_game.turn_num
          win_type << result_game.win_type
        end

        winners.flatten!
        average_turn = turns.reduce(:+).to_f / turns.length

        victories = winners.inject({}) do |hash, player|
          hash[player.name] = 0 if hash[player.name].nil?
          hash[player.name] += 1
          hash
        end

        puts ["#{number_of_players}", "#{starting_energy}", "#{winning_energy}", '', average_turn, win_type.mode, "#{win_type.percent_of(win_type.mode)}%", win_type.mode_array[-2], "#{win_type.percent_of(win_type.mode_array[-2])}%"].join("\t")
      end
    end
  end
end