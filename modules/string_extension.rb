module StringExtension
    def to_hours
        hours, minutes = self.split(":")
        hours.to_i + minutes.to_i / 60.0
    end
end