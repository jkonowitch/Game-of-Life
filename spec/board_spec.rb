require 'spec_helper'

describe Board do
  let(:coords) { Coords.new(:x => 2, :y => 3) }

  describe "#live!" do
    context "a living cell" do
      before { subject.live! coords }

      it "lives" do
        subject.cells[coords].should be_an_instance_of LiveCell
      end
    end

    context "no living cell" do
      it "returns a dead cell" do
        subject.cells[coords].should be_an_instance_of DeadCell
      end
    end
  end

  describe "#next_tick", :live_neighbors do
    subject { board }

    context "dead cell with 3 live neighbors" do
      before { live_neighbors(3) }

      its(:next_tick) { should have(3).live_cells }
    end

    context "4 adjacent cells" do
      before do
        subject.live!(location)
        live_neighbors(3)
      end

      its(:next_tick) { should have(7).live_cells }
    end

    context "2 live neighbors" do
      before { live_neighbors(2) }

      its(:next_tick) { should have(0).live_cells }
    end
  end
end