require('rspec')
require('spec_buddy')

describe(Station) do
  describe('#station_id') do
    it('returns the ID number of the station') do
      test_station = Station.new({:platform => "Foggy Bottom"})
      test_station.save()
      expect(test_station.station_id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#platform') do
    it('returns the platform name') do
      test_station = Station.new({:platform => "Foggy Bottom"})
      expect(test_station.platform()).to(eq("Foggy Bottom"))
    end
  end

  describe('.all') do
    it('returns a list of all stations -- is empty at first') do
      expect(Station.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a station into the station list') do
      test_station = Station.new({:platform => "Foggy Bottom"})
      test_station.save()
      expect(Station.all()).to(eq([test_station]))
    end
  end

  describe("#==") do
    it('recognizes two stations are the same if the name and ID are the same') do
      test_station = Station.new({:platform => "Foggy Bottom"})
      test_station2 = Station.new({:platform => "Foggy Bottom"})
      expect(test_station).to(eq(test_station2))
    end
  end

  describe(".find") do
    it('finds a specific station by platform name') do
      test_station = Station.new({:platform => "Foggy Bottom"})
      test_station.save()
      test_station2 = Station.new({:platform => "Snake Street"})
      test_station2.save()
      expect(Station.find(test_station.station_id())).to(eq(test_station))
    end
  end

  describe(".service") do
    it('will return line or lines that service each station') do
      test_line = Line.new({:color => "Turquoise"})
      test_line.save()
      test_station = Station.new({:platform => "Foggy Bottom"})
      test_station.save()
      test_line.add_stop(test_station)
      expect(Station.service(test_station.station_id())).to(eq(test_line))
    end
  end

# describe(".service") do
#   it('will return line or lines that service each station') do
#     test_line = Line.new({:color => "Turquoise"})
#     test_line.save()
#     test_station = Station.new({:platform => "Foggy Bottom"})
#     test_station.save()
#     test_line.add_stop(test_station)
    # test_line2 = Line.new({:color => "Sienna"})
    # test_line2.save()
    # test_station = Station.new({:platform => "Foggy Bottom"})
    # test_station.save()
    # test_line.add_stop(test_station)
#     expect(Station.service(test_station.station_id())).to(eq(test_line))
#   end
# end

end
