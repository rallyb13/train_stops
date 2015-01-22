require('sinatra')
require('sinatra/reloader')
require('pg')
also_reload('lib/**/*.rb')
require('./lib/stations')
require('./lib/lines')

DB = PG.connect({:dbname => "trains"})

get('/') do
  @lines = Line.all()
  erb(:index)
end

post('/add_line') do
  color = params.fetch("color")
  @line = Line.new({:color => color, :line_id => line_id})
  @line.save()
  @lines = Line.all()
  erb(:index)
end

get('/lines/:line_id') do
  @line = Line.find(params.fetch("line_id").to_i())
  @stations = Station.all()
  erb(:lines)
end

post('/add_station') do
  platform = params.fetch("platform")
  line_id = params.fetch("line_id").to_i()
  @station = Station.new({:platform => platform})
  @station.save()
  @line = Line.find(line_id)
  @line.add_stop(@station)
  @stations = Station.all()
  erb(:lines)
end
