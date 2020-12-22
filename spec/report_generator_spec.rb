require "report_generator"
require 'tempfile'

describe ReportGenerator do
    let(:output) { Tempfile.new }

    subject(:generator) do 
        input = File.readlines('sample.txt')
        ReportGenerator.new(input, output.path) 
    end


    describe "#initialize" do
        it "should set up instance variables" do
            [:commands, :output_path].each do |attribute|
                expect(generator).to respond_to attribute
            end
        end
    end

    describe "#run" do
        it "should output a report file" do
            generator.run
            expect(File.open(output.path).readlines).to eq(["Lauren: 42 miles @ 34 mph\n", "Dan: 39 miles @ 47 mph\n", "Kumi: 0 miles\n"])
        end
    end
end