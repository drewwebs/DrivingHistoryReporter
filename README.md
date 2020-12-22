# DrivingHistoryReporter

DrivingHistoryReporter is a simple parser that accepts an input via stdin containing driver registrations and trip reports, and outputs a driving record for each driver.

Use `cat your-input.txt | ruby lib/report_generator.rb` to run. A sample file (sample.yml) is provided in the top level directory if needed.

## Object Oriented
I chose to break this problem down into three classes. Deconstructing the problem into objects allowed for appropriately semantic code, without over-abstraction.  
* `ReportGenerator` handles parsing the input file, maintaining a collection on `Driver`s, and generating the report.
* a `Driver` instance holds an array of its own trips, and a method for outputting it's own driving record.  This latter method is utilized by `ReportGenerator` to create each line of the output file.
* a `Trip` instance calculates a trip's duration in hours, holds a record of distance traveled, and validates that the speed is between 5-100mph.  

## Why Named Captures?
An alternative would be to simply split the input line, and reconstruct it into the appropriate variables.  This reconstruction logic can get messy in the case that there are names that contain a space.  Using a regex circumvents this limitation, and utilizing named captures allows for intuitive access to our MatchData object.

## Notes
This code makes a couple of assumptions in addition to those mentioned in the prompt; they are listed below:
* `Driver` names must be unique.
* A driver must be registered before a trip for that driver is logged.  Trips that belong to unregistered drivers will be thrown away.
