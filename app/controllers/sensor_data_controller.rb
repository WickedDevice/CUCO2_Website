class SensorDataController < ApplicationController
  force_ssl except: :batch_create unless Rails.env.development? || Rails.env.test?
  protect_from_forgery with: :null_session
  before_action :set_sensor_datum, only: [:show, :edit, :update, :destroy]

  skip_after_action :verify_authorized, only: :batch_create
  skip_before_action :logged_out_redirect, only: :batch_create

  wrap_parameters false

  # GET /sensor_data
  # GET /sensor_data.json
  def index
    @sensor_data = policy_scope SensorDatum.all.page params[:page]

    respond_to do |format|
      format.html
      format.csv {         send_data( @sensor_data.to_csv,
          filename: "CO2_datapoints_#{Time.zone.now}.csv", 
          disposition: 'inline', type: "multipart/related")
      }
    end
  end

  # GET /sensor_data/1
  # GET /sensor_data/1.json
  def show
  end

  # GET /sensor_data/new
  def new
    @sensor_datum = SensorDatum.new
    authorize @sensor_datum
  end

  # GET /sensor_data/1/edit
  def edit
  end

  # POST /sensor_data
  # POST /sensor_data.json
  def create

     #Can also be created with:
     # => curl -X POST -H "Content-Type: application/json; charset=UTF-8" -d '{"sensor_datum": {"ppm": "400","device_id": "1"}}' localhost:3000/sensor_data.json
     # => curl -X POST -H "Content-Type: application/json; charset=UTF-8" -d '{"sensor_datum": {"ppm": "400", "device_address": "42"}}' localhost:3000/sensor_data.json

    @sensor_datum = SensorDatum.new(sensor_datum_params)
    authorize @sensor_datum

    @sensor_datum.resolve_device_id
    @sensor_datum.resolve_experiment_id

    respond_to do |format|
      if @sensor_datum.save
        format.html { redirect_to @sensor_datum, notice: 'Sensor datum was successfully created.' }
        format.json { render :show, status: :created, location: @sensor_datum }
      else
        format.html { render :new }
        format.json { render json: @sensor_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  def batch_create

    device = Device.find_by(address: params["device_address"])

    @success = true
    begin
      new_params = JSON.parse(p ApplicationHelper::Vignere.decrypt(params["encrypted"], device.encryption_key))
    rescue => e
      @success = false
      puts "Error decoding JSON:\t#{e}"
      render :batch_create, layout: false, formats: :html
      return
    end

    @success &= SensorDatum.batch_create(new_params["sensor_datum"])

    if(new_params["experiment_ended"] == "true")
      device.checkin(new_params["sensor_datum"]["experiment_id"].to_i)
    end

    render :batch_create, layout: false, formats: :html
  end

  # PATCH/PUT /sensor_data/1
  # PATCH/PUT /sensor_data/1.json
  def update
    respond_to do |format|
      if @sensor_datum.update(sensor_datum_params)
        format.html { redirect_to @sensor_datum, notice: 'Sensor datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensor_datum }
      else
        format.html { render :edit }
        format.json { render json: @sensor_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensor_data/1
  # DELETE /sensor_data/1.json
  def destroy
    @sensor_datum.destroy
    respond_to do |format|
      format.html { redirect_to sensor_data_url, notice: 'Sensor datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor_datum
      if(params.has_key? :id)
        @sensor_datum = SensorDatum.find(params[:id])
        authorize @sensor_datum
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_datum_params
      params.require(:sensor_datum).permit(:ppm, :device_id, :experiment_id, :device_address)#, :sensor_datum => [:ppm => []])
    end
end
