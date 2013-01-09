class Board
  attr_reader :cells

  def initialize
    @cells = CellMap.new
  end

  def live!(location)
    cells[location] = LiveCell.new(:location => location, :cell_map => cells)
  end

  def live_cells
    cells.live_cells
  end

  def next_tick
    cells.reduce(Board.new) do |board, cell|
      board.live!(cell.location) if cell.next_generation.alive?
      next board
    end
  end
end