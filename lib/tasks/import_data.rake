task :import_data => :environment do
  Station.create_stations
  Station.create_routes
  Line.create_lines
  p 'Data imported with success.'
end
