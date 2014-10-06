require 'csv'

class Line < Neo4j::Rails::Model
  property :number, :type => Fixnum, index: :exact
  property :name, :type => String
  property :colour, :type => String
  property :stripe, :type => String

  has_n(:stations)

  # Import all lines from CSV
  def self.create_lines
    file = Rails.root.join('data', 'routes.csv')
    CSV.foreach(file, headers: :first_row) do |row|
      create(number: row[0],
             name: row[1],
             colour: row[2],
             stripe: row[3])
    end
  end

  def add_stations(stations)
    stations.each do |station|
      self.stations << station
    end

    self.save
  end
end
