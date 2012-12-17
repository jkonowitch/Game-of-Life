class CoordsHash < Hash
  def []=(coords, v)
    super coords.to_sym, v
  end

  def [](coords)
    super coords.to_sym
  end
end

class Coords
  attr_reader :x, :y

  def initialize(coords)
    @x = coords[:x]
    @y = coords[:y]
  end

  def neighbors
    x_range = [x-1, x, x+1]
    y_range = [y-1, y, y+1]
    results = []

    x_range.product(y_range) do |x2, y2|
      results << Coords.new(:x => x2, :y => y2) unless x2 == x and y2 == y
    end

    results
  end

  def to_sym
    "#{x},#{y}".to_sym
  end
end