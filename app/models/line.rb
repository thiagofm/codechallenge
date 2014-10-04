class Line < Neo4j::Rails::Model
  property :id, :type => Fixnum, index: :exact
  property :name, :type => String
  property :colour, :type => String
  property :stripe, :type => String

  has_n(:stations)
end
