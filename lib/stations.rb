class Station

  attr_reader(:station_id, :platform)

  define_method(:initialize) do |attributes|
    @station_id = attributes[:station_id]
    @platform = attributes[:platform]

  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM stations;")
    stations = []
    returned_stations.each do |station|
      station_id = station.fetch("station_id").to_i()
      platform = station.fetch("platform")
      stations.push(Station.new({:station_id => station_id, :platform => platform}))
    end
    stations
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stations (platform) VALUES ('#{@platform}') RETURNING station_id;")
    @station_id = result.first().fetch("station_id").to_i()
  end

  define_method(:==) do |other_guy|
    self.station_id().==(other_guy.station_id()).&(self.platform().==(other_guy.platform()))
  end

  define_singleton_method(:find) do |search_term|
    found_station = nil
    Station.all().each() do |station|
      if station.station_id().eql?(search_term)
        found_station = station
      end
    end
    found_station
  end

  define_singleton_method(:service) do |this_station_id|
    # this_station = DB.exec("SELECT * FROM stations WHERE RETURNING station_id;")

    this_station.station_id()
    return_lines = DB.exec("SELECT * FROM stops WHERE station_id = #{this_station};")
    station_lines = return_lines.first().fetch("line_id").to_i()
    station_lines
  end
end
