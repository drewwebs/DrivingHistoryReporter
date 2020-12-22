require 'byebug'
require_relative './driver'
require_relative './trip'

class ReportGenerator
    attr_accessor :commands, :output_path

    def initialize(commands, output_path="report.yml")
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
            command = command.split
            if command[0] == "Driver"
                driver_name = command[1..-1].join(" ")
                drivers.push(Driver.new(driver_name))  # create new drivers on 'Driver' command and add to tracked drivers
            else
                driver = drivers.select { |driver| driver.name == command[1] }[0]
                trip = Trip.new(*command[2..-1])
                driver.receive_trip(trip)  # create a new trip and assign to driver on 'Trip' command
            end
        end
        
        drivers.sort_by!(&:total_distance).reverse!
    end
end
# Will there be situations where a trip record for a driver occurs before the driver's registration?
# Can two drivers have the same name?

if $PROGRAM_NAME == __FILE__
    ReportGenerator.new($stdin).run
end