require "spec_helper"

describe ToyRobot::Simulator do
  let(:table) { ToyRobot::Table.new(5,5) }
  subject { ToyRobot::Simulator.new(table) }

  it "places the robot on to a valid position" do
    expect(ToyRobot::Robot).to receive(:new)
      .with(0, 0, "NORTH")
      .and_return(double)
    subject.place(0, 0, "NORTH")
    expect(subject.robot).not_to be_nil
  end

  it "cannot place the robot on to an invalid position" do
    expect(ToyRobot::Robot).not_to receive(:new)
    subject.place(5,5, "NORTH")
    expect(subject.robot).to be_nil
  end

  context "when robot has been placed" do
    let(:robot) { instance_double(ToyRobot::Robot) }
    before { allow(subject).to receive(:robot).and_return(robot) }

    it "tells the robot to move" do
      expect(robot).to receive(:move)
      subject.move
    end

    it "tells the robot to turn left" do
      expect(robot).to receive(:turn_left)
      subject.turn_left
    end

    it "tells the robot to turn right" do
      expect(robot).to receive(:turn_right)
      subject.turn_right
    end

    it "tells the robot to report" do
      expect(robot).to receive(:report) { { north: 3, east: 3, direction: "NORTH" }}
      message = "Robot is currently at (3, 3) and it's facing NORTH\n"
      expect { subject.report }.to output(message).to_stdout
    end

    context "robot placed at table boundary" do
      before do
        subject.place(0, 4, "NORTH")
      end
      it "cannot move past the table boundary" do
        subject.move
        message = "Robot is currently at (0, 4) and it's facing NORTH\n"
        expect { subject.report }.to output(message).to_stdout
      end
    end
  end
end
