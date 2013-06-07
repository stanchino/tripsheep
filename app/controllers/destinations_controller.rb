class DestinationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_trip

  # GET /destinations
  # GET /destinations.json
  def index
    @destinations = Destination.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @destinations }
    end
  end

  # GET /destinations/1
  # GET /destinations/1.json
  def show
    @destination = Destination.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @destination }
    end
  end

  # GET /destinations/new
  # GET /destinations/new.json
  def new
    @destination = @trip.destinations.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @destination }
    end
  end

  # GET /destinations/1/edit
  def edit
    @destination = Destination.find(params[:id])
  end

  # POST /destinations
  # POST /destinations.json
  def create
    @destination = @trip.destinations.build
    @destination.insert_at(params[:position])

    respond_to do |format|
      if @destination.save
        from = @destination.last? ? @destination.higher_item : @destination
        to = @destination.last? ? @destination : @destination.lower_item
        format.html { render partial: "trips/interval", locals: { from: from, to: to } }
        format.json { render json: @destination, status: :created, destination: @destination }
      else
        format.html { render action: "new" }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /destinations/1
  # PUT /destinations/1.json
  def update
    @destination = Destination.find(params[:id])

    respond_to do |format|
      if @destination.update_attributes(params[:destination])
        format.html { redirect_to @destination, notice: 'Destination was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destinations/1
  # DELETE /destinations/1.json
  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy

    respond_to do |format|
      format.html { redirect_to trip_path(params[:trip_id]) }
      format.json { head :no_content }
    end
  end
  
  def get_trip
    @trip = Trip.find(params[:trip_id])
  end
end
