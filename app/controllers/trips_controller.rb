class TripsController < ApplicationController
  include ControllerConstants::Trips
  layout "application"
  
  before_filter :authenticate_user!
  before_filter :map_options

  # GET /trips
  # GET /trips.json
  def index
    @trips = current_user.trips
    @trip = Trip.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    @map_options = @map_options[:defaults] 
    @map_options[:direction] = @trip.directions

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = Trip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = current_user.trips.create
    @trip.update_attributes(params[:trip])

    respond_to do |format|
      if @trip.save
        format.html { redirect_to trips_path, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])

    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to trip_path(@trip), notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

  def map_options
    @map_options = MAP_OPTIONS
  end
end
