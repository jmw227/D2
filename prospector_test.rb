#gold_rush_test.rb
require 'minitest/autorun'
require_relative 'prospector'
require_relative 'map'

class ProspectorTest < Minitest::Test

  def test_prospector_init
    dummy_loc = Minitest::Mock.new("test Location")
    pros = Prospector.new(0, dummy_loc, 0)
	refute_nil pros
  end
  
  #UNIT TESTS FOR METHOD get_gold(rng)
  #Equivalence classes:
  #max_gold = 0 -> returns 0
  #max_gold > 0 -> returns value from Random Number Generator
  
  #test if max gold is not equal to 0 we get a value from the 
  #random number generator
  def test_get_gold_has_max
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.max_gold;1;end
    p = Prospector.new(0, mock_loc, 0)
	mock_rng = Minitest::Mock.new("mock_rng")
	def mock_rng.rand(a);1;end
	assert_equal p.get_gold(mock_rng), 1
  end
  
  
  #test if max gold is 0 we will always get 0
  #EDGE CASE
  def test_get_gold_zero_max
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.max_gold; 0;end
    p = Prospector.new(0, mock_loc, 0)
	mock_rng = Minitest::Mock.new("mock_rng")
	def mock_rng.rand(a);2;end
	assert_equal p.get_gold(mock_rng), 0
  end
  
  #UNIT TESTS FOR METHOD get_silver(rng)
  #Equivalence classes:
  # max_silver = 0 -> returns 0
  #max_silver > 0 -> returns value from Random Number Generator
  
  #test if max silver is greater than 0 we get a value from the 
  #random number generator
  def test_get_silver_has_max
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.max_silver;1;end
    p = Prospector.new(0, mock_loc, 0)
	mock_rng = Minitest::Mock.new("mock_rng")
	def mock_rng.rand(a);1;end
	assert_equal p.get_silver(mock_rng), 1
  end
  
  
  #test if max gold is 0 we will always get 0
  #EDGE CASE
  def test_get_silver_zero_max
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.max_silver; 0;end
    p = Prospector.new(0, mock_loc, 0)
	mock_rng = Minitest::Mock.new("mock_rng")
	def mock_rng.rand(a);2;end
	assert_equal p.get_silver(mock_rng), 0
  end
  
  #UNIT TESTS FOR METHOD string_findings
  #Equivalence classes:
  #gold_found = 0 and silver_found = 0 -> 
  #"No precious metals found" string
  #gold_found = 0 and silver_found > 0 -> 
  #"{silver_found} ounce(s) of silver found" string
  #gold_found > 0 and silver_found = 0 -> 
  #"{gold_found} ounce(s) of gold found)" string
  #gold_found > 0 and silver_found > 0 -> 
  #"{gold_found} ounces of gold and {silver_found} ounces of silver found" string

  #test if gold_found and silver_found are both 0
  #EDGE CASE
  def test_string_results_both_zero
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.name;'Sutter Creek';end
    p = Prospector.new(0, mock_loc, 0)
	p.silver_found = 0
	p.gold_found = 0
	assert_equal 'Found no precious metals in Sutter Creek',p.string_findings
  end
  
  #test if gold_found and silver_found are both not zero
  def test_string_results_neither_zero
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.name;'Sutter Creek';end
    p = Prospector.new(0, mock_loc, 0)
	p.silver_found = 3
	p.gold_found = 3
	assert_equal 'Found 3 ounce(s) of gold and 3 ounce(s) of silver in Sutter Creek', p.string_findings
  end
  
  #test if gold_found is not zero but silver_found is zero
  #EDGE CASE
  def test_string_results_silver_zero
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.name;'Sutter Creek';end
    p = Prospector.new(0, mock_loc, 0)
	p.silver_found = 0
	p.gold_found = 3
	assert_equal 'Found 3 ounce(s) of gold in Sutter Creek', p.string_findings
  end
  
  #test if gold_found is zero but silver_found is not zero
  #that the correct message string is generated
  #EDGE CASE
  def test_string_results_gold_zero
    mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.name;"Sutter Creek";end
    p = Prospector.new(0, mock_loc, 0)
	p.silver_found = 3
	p.gold_found = 0
	assert_equal '3 ounce(s) of silver found in Sutter Creek', p.string_findings
  end
  
  #UNIT TESTS FOR METHOD change_locations
  #SUCCESS CASES: The next location chosen is a neighbor of the current location
  #FAILURE CASES: The next location chosen is not a neighbor of the current location
  
  #test if the current location is changed and id is set properly
  def test_move
    mock_loc = Minitest::Mock.new "mock_loc"
	def mock_loc.name;"previous location";end
	mock_loc2 = Minitest::Mock.new "mock_loc2"
	def mock_loc2.name;"next location";end
	map = Map.new
	map.nodes = [mock_loc, mock_loc2]
	dummy_rng = Minitest::Mock.new("dummy_rng")
	def mock_loc.choose_neighbor(a);1;end
    p = Prospector.new(0, mock_loc, 0)
	assert_equal mock_loc2, p.move(dummy_rng, map)
	assert_equal 1, p.current_loc_id
  end
  
  
  #UNIT TEST FOR METHOD reset
  #Equivalence class:
  #Integer -> 0
  
  #test if reset sets silver and gold found to 0
  def test_reset
    p = Prospector.new(0,0,0)
	p.silver_found = 5
	p.gold_found = 5
	p.reset
	assert_equal 0, p.silver_found
	assert_equal 0, p.gold_found
  end
  
  #UNIT TEST FOR METHOD leaving?
  #Equivalence classes:
  #num_locations_visited <=3, gold_found = 0 && silver_found = 0 -> true
  #num_locations_visited <=3, gold_found > 0 || silver_found > 0 -> false
  #num_locations_visited > 3, gold_found <= 1 && silver_found <= 2 -> true
  #num_locations_visited > 3, gold_found > 1 || silver_found > 2 -> false
  
  #test if num_locations <=3 and gold_found = 0 and silver_found = 0, we 
  #get true
  #EDGE CASE
  def test_leaving_first_3_true
    p = Prospector.new(0,0,0)
	p.gold_found = 0
	p.silver_found = 0
	p.num_loc_visited = 3
	assert p.leaving?
  end
  
  #test if num_locations <= 3 and gold_found >0 and silver_Found > 0, we 
  #get false
  def test_leaving_first_3_false_both_found
    p = Prospector.new(0,0,0)
	p.gold_found = 3
	p.silver_found = 4
	p.num_loc_visited = 3
	refute p.leaving?
  end
  
  #test if num_locations <= 3 and only gold_found >0, we get false
  
  def test_leaving_first_3_false_gold_found
    p = Prospector.new(0,0,0)
	p.gold_found = 1
	p.silver_found = 0
	p.num_loc_visited = 3
	refute p.leaving?
  end 
  
  #test if num_locations <=3 and only silver_found > 0, we get false
  def test_leaving_first_3_false_silver_found
    p = Prospector.new(0,0,0)
	p.gold_found = 0
	p.silver_found = 1
	p.num_loc_visited = 3
	refute p.leaving?
  end
  
  #test if _num_locations > 3 and silver <=2 and gold <=1, we get true
  #EDGE CASE
  def test_leaving_last_2_true
    p = Prospector.new(0,0,0)
	p.gold_found = 1
	p.silver_found = 2
	p.num_loc_visited = 4
	assert p.leaving?
  end
  
  #test if num_locations > 3 and silver <= 2 and gold > 1, we get false
  def test_leaving_last_2_false_gold_found
    p = Prospector.new(0,0,0)
	p.gold_found = 2
	p.silver_found = 2
	p.num_loc_visited = 4
	refute p.leaving?
  end
  
  #test if num_locations > 3 and silver > 2 and gold <= 1, we get false
  def test_leaving_lst_2_false_silver_found
    p = Prospector.new(0,0,0)
	p.gold_found = 1
	p.silver_found = 3
	p.num_loc_visited = 4
	refute p.leaving?
  end

  #UNIT TEST FOR METHOD cashout
  #equivalence class:
  #total_gold, total silver -> total
  
  #test if cash out properly converts gold and silver to a string cash amount
  def test_cash_out
    p = Prospector.new(0,0,0)
	p.total_gold = 1
	p.total_silver = 1
	assert '21.98', p.cash_out
  end
  
  #UNIT TEST FOR METHOD prospect
  #Equivalence class:
  # num_days -> num_days + 1
  
  #test to see if, regardless of gold_found and silver_found results
  #prospect increments num_days by 1
  def test_prospect
	mock_rng = Minitest::Mock.new("mock_rng")
	def mock_rng.rand;1;end
	mock_loc = Minitest::Mock.new("mock_loc")
	def mock_loc.max_gold;0;end
	def mock_loc.max_silver;0;end
    p = Prospector.new(0,mock_loc,0)
	p.prospect(mock_rng)
	assert 1, p.num_days
  end
end