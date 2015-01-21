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
      if station.platform().eql?(search_term)
        found_station = station
      end
    end
    found_station.station_id().to_i()
  end

end
