require 'rails_helper'

RSpec.describe Line do
  after(:all) do
    Neo4j.shutdown
    `rm -rf db/neo4j-test/`
  end

  context '.create_lines'do
    before do
      Station.create_stations
      Station.create_routes
    end

    it 'parses the file correctly' do
      Line.create_lines
      expect(Line.find(number: 1).name).to eq("Bakerloo Line")
    end
  end
end
