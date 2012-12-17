require 'set'

class Cell
  attr_reader :location, :board

  def initialize(args = {})
    @location = args[:location]
    @board = args[:board]
  end

  def next_generation
    neighbors_to_live.include?(live_neighbor_count) ? LiveCell.new : DeadCell.new
  end

  protected

  def live_neighbor_count
    neighbors.count(&:alive?)
  end

  def neighbors
    location.neighbors.map do |location|
      board.cell_at(location)
    end
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