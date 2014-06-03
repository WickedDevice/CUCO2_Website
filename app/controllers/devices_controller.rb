class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = policy_scope(Device)
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    authorize @device
  end

  # GET /devices/new
  def new
    authorize @device
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
    authorize @device
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    authorize @device

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    authorize @device

    respond_to do |format|
      if @device.update(device_params)
        unless params[:device][:redirect_to].blank?
          redirect_to params[:device][:redirect_to]
          return
        end
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    authorize @device
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def first_contact
    @device = Device.find_by address: params[:address]
    authorize @device

    respond_to do |format|
      format.html {render(layout: false)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name, :address, :notes, :experiment_id)
    end
end
