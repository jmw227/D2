# map.rb
# Contains location, node and map object classes

# Full map object
class Map
  attr_accessor :nodes
  def initialize
    @nodes =
      [Map_Node.new(Location.new('Sutter Creek',     2, 0),  0, [1, 2]),
       Map_Node.new(Location.new('Coloma',           3, 0),  1, [0, 4]),
       Map_Node.new(Location.new('Angels Camp',      4, 0),  2, [0, 3, 4]),
       Map_Node.new(Location.new('Nevada City',      5, 0),  3, [2]),
       Map_Node.new(Location.new('Virginia City',    3, 3),  4, [1, 2, 5, 6]),
       Map_Node.new(Location.new('Midas',            0, 5),  5, [4, 6]),
       Map_Node.new(Location.new('El Dorado Canyon', 0, 10), 6, [4, 5])]
  end
end
# Node object, containing location, id and neighbor ids
class Map_Node
  attr_accessor :location
  attr_accessor :id
  attr_accessor :neighbors
  def initialize(location, newid, neighbors)
    @location = location
    @id = newid
    @neighbors = neighbors
  end
end
# location object, containing name max gold and max silver
class Location
  attr_accessor :name
  attr_accessor :max_gold
  attr_accessor :max_silver
  def initialize(name, max_gold, max_silver)
    @name = name
    @max_gold = max_gold
    @max_silver = max_silver
  end
end
