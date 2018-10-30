#map_test.rb
require 'minitest/autorun'
require_relative 'map'

class MapTest < Minitest::Test

  #UNIT TEST FOR METHOD initialization OF LOCATION
  #test initialization of location object
  def test_location_init
    loc = Location::new("test loc",0, 0, 0, [0, 1])
	refute_nil loc
  end

  #UNIT TEST FOR METHOD choose_neighbor OF LOCATION
  #Equivalence class:
  #rng result -> member of neighbor array
  #This unit test checks to ensure choose neighbor returns
  #a value from the neighbors array of a node
  def test_choose_neighbor
    loc = Location::new("test loc",0, 0, 0, [0, 1])
    mock_rng = Minitest::Mock.new("mock")
	def mock_rng.rand(a);0;end
	assert_equal 0, loc.choose_neighbor(mock_rng)
  end

  #UNIT TEST FOR METHOD intitialization OF MAP
  #test initialization of location object
  def test_map_init
    refute_nil Map::new
  end

  #UNIT TEST FOR METHOD generate_map OF Map
  
  #ensure that generate map adds all predetermined nodes to map
  def test_map_nodes_added
    map = Map::new
    map.generate_map
    assert_equal map.nodes.size, 7
  end
  
end