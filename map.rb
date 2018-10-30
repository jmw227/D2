# map.rb
# Contains location, node and map object classes

# Full map object
class Map
  attr_accessor :nodes
  def initialize
    @nodes = []
  end

  def generate_map
    @nodes =
      [Location.new('Sutter Creek',     0, 2, 0,  [1, 2]),
       Location.new('Coloma',           1, 3, 0,  [0, 4]),
       Location.new('Angels Camp',      2, 4, 0,  [0, 3, 4]),
       Location.new('Nevada City',      3, 5, 0,  [2]),
       Location.new('Virginia City',    4, 3, 3,  [1, 2, 5, 6]),
       Location.new('Midas',            5, 0, 5,  [4, 6]),
       Location.new('El Dorado Canyon', 6, 0, 10, [4, 5])]
  end
end

# location object, containing name max gold and max silver
class Location
  attr_accessor :name
  attr_accessor :id
  attr_accessor :max_gold
  attr_accessor :max_silver
  attr_accessor :neighbors
  def initialize(name, id, max_gold, max_silver, neighbors)
    @name = name
    @id = id
    @max_gold = max_gold
    @max_silver = max_silver
    @neighbors = neighbors
  end

  def choose_neighbor(rng)
    num = rng.rand(@neighbors.size)
    neighbors[num]
  end
end
