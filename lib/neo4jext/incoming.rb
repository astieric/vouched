module Neo4jr

  class Service < Sinatra::Base

    describe "Returns incoming relationships to other nodes for the specified node, where :node_id is the value of the identifier propery of the node or if no identifier is specified you can use the numeric neo4j id."
    optional_param :type, "Specify a type if only certain relationships are of interest"
    get '/nodes/:node_id/incoming_relationships' do
      relationships = Neo4jr::DB.execute do |neo|
        node = neo.find_node(param_node_id)
        if param_relationship_type
          relationship_type = RelationshipType.instance(param_relationship_type)
	   directions = Array.new(relationship_type.to_a.size, Neo4jr::Direction::INCOMING)
          node.getRelationships(relationship_type.to_a.zip(directions).flatten).hashify_objects
        else
          node.getRelationships(Neo4jr::Direction::INCOMING).hashify_objects
        end
      end
      relationships.to_json
    end

  end

end