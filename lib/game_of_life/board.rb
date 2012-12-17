class Board
  attr_reader :cells
  alias :live_cells :cells

  def initialize
    @cells = CoordsHash.new { |_, coords| DeadCell.new(:location => coords, :board => self) }
  end

  def live!(location)
    cells[location] = LiveCell.new(:location => location, :board => self)
  end

  def cell_at(location)
    cells[location]
  end

  def live_cell_locations
    live_cells.map { |_, cell| cell.location }
  end

  def next_tick
    cells.reduce(Board.new) do |board, hsh_arr|
      cell = hsh_arr.last
      board.live!(cell.location) if cell.next_generation.alive?
      next board
    end
  end
end