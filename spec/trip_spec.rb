require "trip"

describe Trip do
    let(:valid_trip) { Trip.new("00:00", "01:00", 60) }
    let(:invalid_trip) { Trip.new("00:00", "01:00", 150) }
    
    describe "#initialize" do
        it "should set up instance variables" do
            [:distance, :duration_in_hours].each do |attribute|
                expect(valid_trip).to respond_to attribute
            end
        end
    end
    
    describe "#valid_speed?" do 
        context "given a speed between 5-100mph" do
            it "returns true" do
                expect(valid_trip.valid_speed?).to be true
            end
        end
        context "given an invalid speed" do
            it "returns false" do
                expect(invalid_trip.valid_speed?).to be false
            end
        end
    end
    
end