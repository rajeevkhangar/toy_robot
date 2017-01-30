require "spec_helper"

describe ToyRobot::Robot do
  subject { ToyRobot::Robot.new(0) }

  it "moves 3 spaces" do
    3.times { subject.move }
    expect(subject.position).to eq(3)
  end
end
