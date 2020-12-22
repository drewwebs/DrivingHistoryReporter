require_relative '../modules/string_extension'

describe StringExtension do
    describe "to_hours" do
        it "converts a given time to number hours since midnight" do
            expect("01:30".to_hours).to eq(1.5)
        end
    end

    describe "parse_trip" do
        test_trip = "Trip Dan 07:15 07:45 17.3".parse_trip

        it "returns a MatchData object" do
            expect(test_trip.class).to eq(MatchData)
        end
        
        it "contains appropriate parameters" do
            [:name, :start, :finish, :dist].each do |value|
                expect(test_trip[value]).to be_truthy
            end
        end

        it "extracts correct name" do
            expect(test_trip[:name]).to eq("Dan")
        end

        it "extracts correct start" do
            expect(test_trip[:start]).to eq("07:15")
        end

        it "extracts correct finish" do
            expect(test_trip[:finish]).to eq("07:45")
        end

        it "extracts correct dist" do
            expect(test_trip[:dist]).to eq("17.3")
        end

        it "catches larger distances" do
            long_trip = "Trip Dan 07:15 07:45 170.55".parse_trip
            expect(long_trip[:dist]).to eq("170.55")
        end

        it "accepts names with spaces" do
            trip = "Trip Maker Bayfield 07:15 07:45 17.3".parse_trip
            expect(trip[:name]).to eq("Maker Bayfield")
        end
    end
end