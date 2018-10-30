# gold_rush.rb
require_relative 'map'
require_relative 'prospector'
# Prospector class for gold_rush

unless (ARGV[0].to_i.is_a? Integer) &&
       (ARGV[1].to_i.is_a? Integer) && (ARGV[1].to_i > 0)
  puts "Usage:\n"\
       "ruby gold_rush.rb *seed* *num_prospectors*\n"\
       "*seed* should be an integer\n"\
       "*num_prospectors* should be a non-negative integer\n"\

  exit 5
end

seed = ARGV[0].to_i
num_prospectors = ARGV[1].to_i
map = Map.new
map.generate_map
rng = Random.new seed

(0..(num_prospectors - 1)).each do |i|
  p = Prospector.new i, map.nodes[0], 0
  puts("Prospector #{p.id} starting in #{p.current_loc.name}")
  done = true
  while done
    p.prospect(rng)
    puts("\t" + p.string_findings)
    if p.leaving? && p.num_loc_visited < 5
      p.move(rng, map)
    elsif p.leaving? && p.num_loc_visited == 5
      done = false
    end
  end
  cash = p.cash_out
  puts("After #{p.num_days} days, Prospector ##{p.id} "\
  "returned to San Francisco with:\n\t"\
  "#{p.total_gold} ounces of gold\n\t"\
  "#{p.total_silver} ounces of silver")
  puts("\tReturning home with " + cash)
end
