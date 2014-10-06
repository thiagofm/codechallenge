require 'csv'

class Station < Neo4j::Rails::Model
  property :number, :type => Fixnum, index: :exact
  property :latitude, :type => Float
  property :longitude, :type => Float
  property :name, :type => String
  property :display_name, :type => String
  property :zone, :type => Fixnum
  property :total_lines, :type => Fixnum
  property :rail, :type => Fixnum

  # Calculate the approximate time it takes to get from station_1 to station_2
  # criteria:
  # same line: 3 minutes
  # change line: 12 minutes
  def self.approximate_time(station_1, station_2)
    last_line = nil
    distance = nil
    self.route_between(station_1, station_2).inject(0) do |sum, route|
      current_line = route['line']
      distance = route['distance']

      if distance.present?
        if last_line.present? && current_line != last_line
          sum += 12
        else
          sum += 3
        end

        distance = nil
      end

      last_line = route['line'] if route['line'].present?
      sum
    end
  end

  # Calculate a route between station_1 and station_2
  def self.route_between(station_1, station_2)
    Neo4j::Algo.dijkstra_path(station_1, station_2)
               .outgoing(:route)
               .cost_evaluator{|rel, a, b| rel.props["distance"] }
               .map {|item| item.props }
  end

  # Exports all stations from csv
  def self.create_stations
    file = Rails.root.join('data', 'stations.csv')
    CSV.foreach(file, headers: :first_row) do |row|
      create(number: row[0],
             latitude: row[1],
             longitude: row[2],
             name: row[3],
             display_name: row[4],
             zone: row[5],
             total_lines: row[6],
             rail: row[7])
    end
  end

  # Exports all routes from csv
  def self.create_routes
    file = Rails.root.join('data', 'lines.csv')
    CSV.foreach(file, headers: :first_row) do |row|
      from = Station.find(number: row[0].to_i)
      to = Station.find(number: row[1].to_i)
      from.add_route(to, row[2])
    end
  end

  # Adds route between the current station with another one
  def add_route(station, line)
    Neo4j::Transaction.run do
      rel = Neo4j::Relationship.create(:route, self, station)
      rel[:distance] = 1.0
      rel[:line] = line
    end

    self
  end
end
