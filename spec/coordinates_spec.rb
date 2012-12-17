require 'spec_helper'

describe Coords do
  describe '#nieghbors' do
    subject { Coords.new(:x => 3, :y => 3) }

    its(:neighbors) { should have(8).elements }

    it "range makes sense" do
      subject.neighbors.all? do |coord|
        ((subject.x - 1)..(subject.x + 1)).include?(coord.x) \
        and
        ((subject.y - 1)..(subject.y + 1)).include?(coord.y)
      end.should be_true
    end

    it "doesn't include the sender's coords" do
      subject.neighbors.map(&:to_sym).should_not include(subject.to_sym)
    end
  end
end