require 'set'

class Cell
  attr_reader :location, :cell_map

  def initialize(args = {})
    @location = args[:location]
    @cell_map = args[:cell_map]
  end

  def next_generation
    neighbors_to_live.include?(live_neighbor_count) ? LiveCell.new : DeadCell.new
  end

  def neighbors
    @neighbors ||= location.adjacent_locations.map { |location| cell_map[location] }
  end

  protected

  def live_neighbor_count
    neighbors.count(&:alive?)
  end
end

class DeadCell < Cell
  def alive?
    false
  end

  private

  def neighbors_to_live
    Set.new [3]
  end
end

class LiveCell < Cell
  def alive?
    true
  end

  private

  def neighbors_to_live
    Set.new [2,3]
  end
end

class CellMap
  include Enumerable

  attr_reader :cells
  alias :live_cells :cells

  def initialize
    @cells = {}
  end

  def []=(location, cell)
    cells[location.to_sym] = cell
  end

  def [](location)
    cells[location.to_sym] || DeadCell.new(:location => location, :cell_map => self)
  end

  # Iterates through the set of all live cells along with
  # their neighbors; dead cells adjacent to live cells
  # can be revived, and thus must be passed to any
  # interested callers.
  def each
    (live_cells.values + live_cells.map { |_, cell| cell.neighbors })
      .flatten
      .uniq
      .each { |c| yield c }
  end
end