class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /cities
  # GET /cities.json
  def index
    neo = Neography::Rest.new
    r = neo.execute_query("START n=node(*) RETURN n;")
    r["data"].shift # first node is wacky
    @cities = r["data"].map { |node| OpenStruct.new(node[0]["data"]) }
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  # GET /cities/new
  def new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    neo = Neography::Rest.new
    city = neo.create_node(params[:city])
    redirect_to cities_path
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params[:city]
    end
end
