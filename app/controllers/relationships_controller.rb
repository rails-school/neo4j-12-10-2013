class RelationshipsController < ApplicationController
  def create
    neo = Neography::Rest.new
    r = neo.create_relationship("road", params[:relationship][:city_a], params[:relationship][:city_b])
    neo.set_relationship_properties(r, {length: params[:relationship][:distance].to_i})
    redirect_to relationships_path
  end

  def index
    neo = Neography::Rest.new
    # get all nodes
    r = neo.execute_query("START n=node(*) RETURN n;")
    r["data"].shift # first node is wacky
    @cities = r["data"].map { |node|
      OpenStruct.new(node[0]["data"].merge(id: node[0]["self"].match(/node\/(\d+)$/)[1].to_i))
    }

    # get relationships
    r = neo.execute_query("START r=rel(*) RETURN r;")
    @roads = r["data"].map { |rel|
      OpenStruct.new(
        rel[0]["data"].merge({
          start: rel[0]["start"].match(/node\/(\d+)$/)[1].to_i,
          end: rel[0]["end"].match(/node\/(\d+)$/)[1].to_i
        })
      )
    }
  end
end
