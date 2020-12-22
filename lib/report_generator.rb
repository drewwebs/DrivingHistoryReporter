require_relative './driver'
require_relative './trip'
require_relative '../modules/string_extension'
require 'byebug'


class ReportGenerator
    attr_accessor :commands, :output_path

    def initialize(commands, output_path="report.txt")
        @commands = commands
        @output_path = output_path
    end
    
    def run
        records = get_all_driving_records
        
        records.each { |driver| report << driver.get_driving_record + "\n" }
        report.close
    end

    private

    def report
        @report ||= File.open(self.output_path, "w")
    end 

    def get_all_driving_records
        drivers = []
        commands.each do |command| 
            command.chomp!
            if command.split[0] == "Driver"
                driver_name = command.split[1..-1].join(" ")
                drivers.push(Driver.new(driver_name))  # create new drivers on 'Driver' command and add to tracked drivers
            else
                new_trip = command.parse_trip
                name, start, finish, dist = new_trip.values_at(:name, :start, :finish, :dist)
                driver = drivers.select { |driver| driver.name == name }.first
                trip = Trip.new(start, finish, dist)
                driver.receive_trip(trip) if driver  # create a new trip and assign to driver on 'Trip' command
            end
        end
        
        drivers.sort_by!(&:total_distance).reverse!
    end
end


if $PROGRAM_NAME == __FILE__
    ReportGenerator.new($stdin).run
end