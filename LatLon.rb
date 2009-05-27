class LatLon
  attr_reader :latitude, :longitude, :elevation
  def initialize(latitude, longitude, elevation = nil)
    convertDD(latitude, longitude)
    if elevation == nil
       @elevation= 0
    else
      @elevation = elevation
      #if the point does have an elevation will use later for conversions into different measurements
    end
  end
  def convertDD(latitude, longitude)
    #regex to determine specific type of xy notation
    case latitude
    when /[0-9]+[N]/
      @latitude = latitude.sub('N', '').to_f
    when  /[0-9]+[S]/
      @latitude =  latitude.sub('S', '').to_f * -1
    end
  
    case longitude
    when /[0-9]+[E]/
      @longitude = longitude.sub('E', '').to_f
    when /[0-9]+[W]/
      @longitude = longitude.sub('W', '').to_f * -1
    end
  end
end