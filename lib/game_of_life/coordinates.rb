class Coords
  attr_reader :x, :y

  def initialize(coords)
    @x = coords[:x]
    @y = coords[:y]
  end

  def to_sym
    "#{x},#{y}".to_sym
  end

  def ==(other_coords)
    to_sym == other_coords.to_sym
  end

  def adjacent_locations
    Math.cartesian(range(x), range(y)).reduce([]) do |res, (x2, y2)|
      location = Coords.new(:x => x2, :y => y2)
      res << location unless location == self
      next res
    end
  end

  private

  def range(p)
    (p-1..p+1).to_a
  end
end