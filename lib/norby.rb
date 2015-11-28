require 'norby/version'
require 'colorize'

# The wrapper module for the gem
module Norby
  DIRECTIONS = { 'NORTH' => 0, 'EAST' => 1, 'SOUTH' => 2, 'WEST' => 3 }

  # Actual Robot logic
  class Robot
    def initialize
      @curr_place_x = 0
      @curr_place_y = 0
      @curr_dir = 0
    end

    def start
      puts 'Enter list of commands each followed by RETURN,'.colorize(:blue)
      puts "Then enter an empty command to stop:\n".colorize(:blue)
      inputs = []
      loop do
        input = gets.chomp
        break if input.empty?
        inputs << input
      end

      issue_commands(inputs)
    end

    private

    def issue_commands(inputs)
      inputs.each_with_index do |input, index|
        if index == 0
          parse_input(input)
        else
          meth_name = input.downcase
          send(meth_name) # if respond_to?(meth_name.to_sym)
        end
      end
    end

    def parse_input(input)
      if /^PLACE [0-4],[0-4],(NORTH|EAST|SOUTH|WEST)$/ =~ input
        arr = input.split(',')
        place(arr[0].split(' ')[1].to_i, arr[1].to_i, arr[2])
      else
        puts 'Somthing went wrong with PLACE command, exiting..'
          .colorize(:red)
      end
    end

    def place(x, y, dir)
      @curr_place_x = x
      @curr_place_y = y
      @curr_dir = DIRECTIONS[dir]
    end

    def move
      case @curr_dir
      when 0, 1
        change_place(4, '+')
      when 2, 3
        change_place(0, '-')
      end
    end

    def right
      new_dir = @curr_dir - 1
      new_dir > 3 ? @curr_dir = 0 : @curr_dir = new_dir
    end

    def left
      new_dir = @curr_dir - 1
      new_dir < 0 ? @curr_dir = 3 : @curr_dir = new_dir
    end

    def report
      puts "#{@curr_place_x},#{@curr_place_y},#{DIRECTIONS.key(@curr_dir)}"
        .colorize(:green)
    end

    def change_place(new_pos, operation)
      new_place = 0
      @curr_dir == 0 ? axis = :y : axis = :x
      eval("new_place = @curr_place_#{axis} #{operation} 1")
      eval("@curr_place_#{axis} = new_place") if new_place < new_pos 
    end
  end
end
