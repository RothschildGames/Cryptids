#!/usr/bin/env ruby

require './cryptids'

case ARGV[0]
  when /o(ptions)?/
    run_multiple_options_games
  when /m(ulti)?/
    run_multiple_games
  when /s(ingle)?/
    run_single_game(:should_log => true)
  else
    puts 'OPTIONS:'
    puts '[s]ingle - run a single game'
    puts '[m]ulti - run multiple games'
    puts '[o]ptions - run a multivariant test of 1000 games each'
end