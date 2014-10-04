class Station < Neo4j::Rails::Model
  property :id, :type => String, index: :exact
  property :latitude, :type => Float
  property :longitude, :type => Float
  property :name, :type => String
  property :display_name, :type => String
  property :zone, :type => Fixnum
  property :total_lines, :type => Fixnum
  property :rails, :type => Fixnum
end
