require 'spec_helper'

describe Coords do
  describe '#adjacent_locations' do
    subject { Coords.new(:x => 3, :y => 3) }

    its(:adjacent_locations) { should have(8).elements }

    it "range makes sense" do
      subject.adjacent_locations.all? do |coord|
        ((subject.x - 1)..(subject.x + 1)).include?(coord.x) \
        and
        ((subject.y - 1)..(subject.y + 1)).include?(coord.y)
      end.should be_true
    end

    it "doesn't include the sender's coords" do
      subject.adjacent_locations.should_not include(subject)
    end
  end
end