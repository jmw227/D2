# gold_rush.rb
require_relative 'map.rb'

class Prospector
  attr_accessor :id
  attr_accessor :total_gold
  attr_accessor :total_silver
  attr_accessor :num_loc_visited
  attr_accessor :num_days
  attr_accessor :current_loc
  def initialize(id, loc)
    @id = id
    @current_loc = loc
	@total_gold = 0
	@total_siver = 0
	@num_loc_visited = 1
	@num_days = 0
	@current_loc = loc
  end	
  def prospect(rng)

	if current_loc.max_gold == 0
	  gold_found = 0
	else
      gold_found = rng.rand(current_loc.max_gold+1)
	end
	if current_loc.max_silver == 0
	  silver_found = 0
	else
	  silver_found = rng.rand(current_loc.max_silver+1)
	end
	if gold_found ==  0 && gold_found == 0 
	  puts "No precious metals were found"
	elsif gold_found == 0
	  puts "#{silver_found} ounces of silver found"
	elsif  silver_found == 0
	  puts "#{gold_found} ounces of gold found"
	else
	  puts "#{gold_found} ounces of gold and #{silver_found} ounces of silver found"
	end
  end
end

seed = 1
map = Map.new()
rng = Random.new(seed)
p = Prospector.new(0, map.nodes[0].location)
p.prospect(rng)