class Driver
    attr_reader :name, :trips
    attr_accessor :total_distance, :total_hours

    def initialize(name)
        @name = name
        @trips = []
        @total_distance = 0
        @total_hours = 0
    end

    def receive_trip(trip)
        return if !trip.valid_speed?
        self.trips.push(trip)
        self.total_distance += trip.distance
        self.total_hours += trip.duration_in_hours
    end

    def get_driving_record
        if self.trips.length > 0
            "#{self.name}: #{self.total_distance.round} miles @ #{(self.total_distance/self.total_hours).round} mph"
        else
            "#{self.name}: 0 miles"
        end
    end

end