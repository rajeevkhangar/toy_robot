module ToyRobot
  class Simulator
    attr_reader :robot

    def initialize(table)
      @table = table
    end

    def place(east, north, facing)
      return unless @table.valid_location?(east, north)
      @robot = Robot.new(east, north, facing)
    end

    def move
      return unless @table.valid_location?(*robot.next_move)
      robot.move
    end

    def turn_left
      robot.turn_left
    end

    def turn_right
      robot.turn_right
    end

    def report
      position = robot.report
      puts "Robot is currently at (#{position[:north]}, #{position[:east]})" + " and it's facing #{position[:direction]}"
    end

  end
end
