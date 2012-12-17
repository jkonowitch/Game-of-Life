shared_context "board, coords and live neighbor factory", :live_neighbors do
  let(:board) { Board.new }
  let(:location) { Coords.new(:x => 2, :y => 2) }

  def live_neighbors(num)
    location
      .neighbors
      .take(num)
      .each { |coords| board.live!(coords) }
  end
end