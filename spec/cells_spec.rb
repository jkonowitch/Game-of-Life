require 'spec_helper'

describe DeadCell do
  subject { DeadCell.new }

  it { should_not be_alive }

  describe "#next_generation", :live_neighbors do
    subject { DeadCell.new(:location => location, :board => board) }

    context "three live neighbors" do
      before { live_neighbors(3) }

      its(:next_generation) { should be_an_instance_of LiveCell }
    end

    context "no live neighbors" do
      its(:next_generation) { should be_an_instance_of DeadCell }
    end
  end
end

describe LiveCell do
  subject { LiveCell.new }

  it { should be_alive }

  describe "#next_generation", :live_neighbors do
    subject { LiveCell.new(:location => location, :board => board) }

    context "four live neighbors" do
      before { live_neighbors(4) }

      its(:next_generation) { should be_an_instance_of DeadCell }
    end

    context "no live neighbors" do
      its(:next_generation) { should be_an_instance_of DeadCell }
    end

    context "two live neighbors" do
      before { live_neighbors(2) }

      its(:next_generation) { should be_an_instance_of LiveCell }
    end
  end
end