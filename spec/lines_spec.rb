require('rspec')
require('spec_buddy')

describe(Line) do
  describe('#line_id') do
    it('returns the ID number of the train line') do
      test_line = Line.new({:color => "Turquoise"})
      test_line.save()
        expect(test_line.line_id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#color') do
    it('returns the name/color of the train line') do
      test_line = Line.new({:color => "Turquoise"})
      expect(test_line.color()).to(eq("Turquoise"))
    end
  end

  describe("#stop_ids") do
    it('returns the stations on the train line -- is empty at first') do
      test_line = Line.new({:color => "Turquoise"})
      expect(test_line.stop_ids()).to(eq([]))
    end
  end

  describe('.all') do
    it('returns list of all train lines--begins empty') do
      expect(Line.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a new train line to the list of train lines') do
      test_line = Line.new({:color => "Turquoise"})
      test_line.save()
      expect(Line.all()).to(eq([test_line]))
    end
  end

  describe('#==') do
    it('recognizes that a line is the same if it has the same color & id') do
      test_line = Line.new({:color => "Turquoise"})
      test_line2 = Line.new({:color => "Turquoise"})
      expect(test_line).to(eq(test_line2))
    end
  end

  describe("#add_stop") do
    it('adds a stop to a train line') do
      test_line = Line.new({:color => "Turquoise"})
      test_line.save()
      test_station = Station.new({:platform => "Foggy Bottom"})
      test_station.save()
      expect(test_line.add_stop(test_station)).to(be_an_instance_of(Fixnum))
    end
  end

  describe(".find") do
    it('finds a specific line') do
      test_line = Line.new({:color => "Turquoise"})
      test_line.save()
      test_line2 = Line.new({:color => "Sienna"})
      test_line2.save()
      expect(Line.find(test_line2.line_id())).to(eq(test_line2))
    end
  end
end
