#!/usr/bin/env ruby

require './runner/methods'

case ARGV[0]
  when /o(ptions)?/
    run_multiple_options_games
  when /m(ulti)?/
    run_multiple_games
  when /s(ingle)?/
    run_single_game(:should_log => true)
  when /p(owers)?/
    run_powers_balance_test
  else
    puts 'OPTIONS:'
    puts '[s]ingle - run a single game'
    puts '[m]ulti - run multiple games'
    puts '[o]ptions - run a multivariant test of 1000 games each'
    puts '[p]powers - run a power test'
end