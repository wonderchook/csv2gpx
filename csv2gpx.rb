require 'rubygems'
require 'fastercsv'
require 'gpx'
require 'LatLon.rb'


inputfile = ARGV[0]
outputfile = ARGV[1]
#grab file info from the commandline

if inputfile.nil? then
  puts 'must have input file name'
  Process.exit
end

if outputfile.nil? then
  #make the outputfile the same name as the input file but with a different extension
  outputfile = inputfile.downcase
  outputfile = outputfile.sub('.csv', '.gpx')
end

segment = GPX::Segment.new

FasterCSV.foreach(inputfile) do |row|
  d = Time.parse('20' << row[2] << row[3])
  #Time.parse needs the full YYYY so added 20 in order to work
  currentpoint = LatLon.new(row[4], row[5], row[6])
  pt = GPX::TrackPoint.new(:lat => currentpoint.latitude.to_f, :lon => currentpoint.longitude.to_f, :time => d, :elevation => currentpoint.elevation)
  begin
    if row[1] =='T' then
      segment.append_point(pt)
    else
    #placeholder to implement waypoints
    end
  rescue => e
    puts e.message << 'record ' << row[0] << ' is bad'
  end
  
    
end

track = GPX::Track.new
track.append_segment(segment)
gpx = GPX::GPXFile.new(:tracks => [track])
gpx.write(outputfile)

