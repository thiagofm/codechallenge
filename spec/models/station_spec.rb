require 'rails_helper'

RSpec.describe Station do
  after(:all) do
    Neo4j.shutdown
    `rm -rf db/neo4j-test/`
  end

  before(:all) do
    Station.create_stations
    Station.create_routes
    Line.create_lines
  end

  context '.approximate_time', wip: true do
    let(:station_11) { Station.find(number: 11) }
    let(:station_212) { station_290 = Station.find(number: 212) }
    let(:station_290) { station_290 = Station.find(number: 290) }
    let(:station_250) { station_290 = Station.find(number: 250) }

    it 'calculates the approximate time to go from station 11 to station 290' do
      expect(Station.approximate_time(station_11, station_290)).to eq(15)
    end

    it 'calculates the approximate time to go from station 11 to station 250' do
      expect(Station.approximate_time(station_11, station_250)).to eq(0)
    end

    it 'calculates the approximate time to go from station 11 to station 212' do
      expect(Station.approximate_time(station_11, station_212)).to eq(3)
    end
  end

  context '.route_between' do
    let(:station_11) { Station.find(number: 11) }
    let(:station_290) { station_290 = Station.find(number: 290) }

    it 'traces the shortest route between two stations' do
      expect(Station.route_between(station_11, station_290)).to eq([{"_neo_id"=>10, "number"=>11, "latitude"=>51.5226, "longitude"=>-0.1571, "name"=>"Baker Street", "display_name"=>"Baker<br />Street", "zone"=>1, "total_lines"=>5, "rail"=>0, "_classname"=>"Station"}, {"_neo_id"=>225, "distance"=>1.0, "line"=>"8"}, {"_neo_id"=>78, "number"=>94, "latitude"=>51.5472, "longitude"=>-0.1803, "name"=>"Finchley Road", "display_name"=>"Finchley<br />Road", "zone"=>2, "total_lines"=>2, "rail"=>0, "_classname"=>"Station"}, {"_neo_id"=>210, "distance"=>1.0, "line"=>"7"}, {"_neo_id"=>257, "number"=>290, "latitude"=>51.5469, "longitude"=>-0.1906, "name"=>"West Hampstead", "display_name"=>"West<br />Hampstead", "zone"=>2, "total_lines"=>1, "rail"=>1, "_classname"=>"Station"}])
    end
  end

  context '.create_routes' do
    it 'correctly sets the route for a station' do
      expect(Station.find(number: 11).rels(:outgoing, :route).first.end_node.number).to be(163)
    end
  end


  context '.create_stations' do
    it 'parses file correctly' do
      expect(Station.find(number: 1).number).to be(1)
      expect(Station.find(number: 2).number).to be(2)
    end
  end

  context '.create_routes' do
    it 'correctly sets the route for a station' do
      expect(Station.find(number: 11).rels(:outgoing, :route).first.end_node.number).to be(163)
    end
  end

  context '#add_routes' do
  end
end
