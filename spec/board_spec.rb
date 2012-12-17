require 'spec_helper'

describe Board do
  let(:coords) { Coords.new(:x => 2, :y => 3) }

  describe "#live!" do
    context "a living cell" do
      before { subject.live! coords }

      it "lives" do
        subject.cell_at(coords).should be_an_instance_of LiveCell
      end
    end

    context "no living cell" do
      it "returns a dead cell" do
        subject.cell_at(coords).should be_an_instance_of DeadCell
      end
    end
  end

  describe "#live_cell_locations" do
    context "live cells" do
      before { subject.live! coords }

      its(:live_cell_locations) { should include(coords) }
    end

    context "no live cells" do
      its(:live_cell_locations) { should be_empty }
    end
  end

  describe "#next_tick", :live_neighbors do
    subject { board }

    context "dead cell with 3 live neighbors" do
      before { live_neighbors(3) }

      its(:next_tick) { should have(1).live_cells }
    end

    context "4 adjacent cells" do
      before do
        subject.live!(location)
        live_neighbors(3)
      end

      its(:next_tick) { should have(4).live_cells }
    end

    context "2 live neighbors" do
      before { live_neighbors(2) }

      its(:next_tick) { should have(0).live_cells }
    end
  end
end