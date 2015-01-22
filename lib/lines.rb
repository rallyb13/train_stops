class Line

  attr_reader(:line_id, :color)

  define_method(:initialize) do |attributes|
    @line_id = attributes[:line_id]
    @color = attributes[:color]
    @stop_ids = []
  end

  define_method(:stop_ids) do
    @stop_ids
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines =[]
    returned_lines.each() do |line|
      line_id = line.fetch("line_id").to_i()
      color = line.fetch("color")
      lines.push(Line.new({:line_id => line_id, :color => color}))
    end
    lines
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (color) VALUES ('#{@color}') RETURNING line_id;")
    @line_id = result.first().fetch("line_id").to_i()
  end

  define_method(:==) do |another_line|
    self.line_id().==(another_line.line_id()).&(self.color().==(another_line.color()))
  end

  define_method(:add_stop) do |station_to_add|
    this_line = self.line_id()
    this_station = station_to_add.station_id()
    this_stop = DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{this_line}, #{this_station}) RETURNING stop_id;")
    @stop_id = this_stop.first().fetch("stop_id").to_i()
    @stop_id
  end

  define_singleton_method(:find) do |line_id|
    found_line = nil
    Line.all().each() do |line|
      if line.line_id().eql?(line_id)
        found_line = line
      end
    end
    found_line
  end

end
