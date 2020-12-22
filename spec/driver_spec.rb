require "driver"
require 'byebug'

describe Driver do
    let(:driver) { Driver.new("Fred") }

    describe "#initialize" do
        it "should set up instance variables" do
            [:name, :trips, :total_distance, :total_hours].each do |attribute|
                expect(driver).to respond_to attribute
            end
        end
    end


    describe "#receive_trip" do
        context "given a valid trip" do
            before(:each) do
                trip = instance_double("Trip")
                allow(trip).to receive(:valid_speed?).and_return(true)
                allow(trip).to receive(:distance).and_return(60)
                allow(trip).to receive(:duration_in_hours).and_return(1)
                driver.receive_trip(trip)
            end

            it "should add to trips" do
                expect(driver.trips).to_not be_empty
            end

            it "should increase total distance" do
                expect(driver.total_distance).to be > 0
            end

            it "should increase total hours" do
                expect(driver.total_hours).to be > 0
            end
        end

        context "given an invalid trip" do
            before(:each) do
                trip = instance_double("Trip")
                allow(trip).to receive(:valid_speed?).and_return(false)
                allow(trip).to receive(:distance).and_return(60)
                allow(trip).to receive(:duration_in_hours).and_return(1)
                driver.receive_trip(trip)
            end

            it "should not add to trips" do
                expect(driver.trips).to be_empty
            end

            it "should not increase total distance" do
                expect(driver.total_distance).to eq(0)
            end

            it "should not increase total hours" do
                expect(driver.total_hours).to eq(0)
            end
        end
    end

    describe "#get_driving_record" do
        context "given a driver with trips" do
            it "should return a summary" do
                trip = instance_double("Trip")
                allow(trip).to receive(:valid_speed?).and_return(true)
                allow(trip).to receive(:distance).and_return(60)
                allow(trip).to receive(:duration_in_hours).and_return(1)
                driver.receive_trip(trip)

                expect(driver.get_driving_record).to eq("Fred: 60 miles @ 60 mph")
            end

        end

        context "given a driver with no trips" do
            it "should return 0 trips" do
                expect(driver.get_driving_record).to eq("Fred: 0 miles")
            end
        end
    end
end