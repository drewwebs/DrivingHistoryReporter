TRIP_REGEX = %r{^Trip\s(?<name>[\w\s]*)\s(?<start>\d{2}:\d{2})\s(?<finish>\d{2}:\d{2})\s(?<dist>[\d.]+)}

module StringExtension
    def to_hours
        hours, minutes = self.split(":")
        hours.to_i + minutes.to_i / 60.0
    end

    def parse_trip
        if matches = self.match(TRIP_REGEX)
            return matches
        end
    end
end