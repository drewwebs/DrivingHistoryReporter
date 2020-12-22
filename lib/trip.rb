require_relative '../modules/string_extension'
require_relative './driver'
String.include StringExtension

class Trip
    attr_reader :distance, :duration_in_hours

    def initialize(start_time, finish_time, distance)
        @duration_in_hours = finish_time.to_hours - start_time.to_hours
        @distance = distance.to_f
    end

    def valid_speed?
        (self.distance / self.duration_in_hours).between?(5, 100)
    end
end

