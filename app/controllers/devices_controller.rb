class DevicesController < ApplicationController
  force_ssl except: :first_contact unless Rails.env.development? || Rails.env.test?
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  skip_after_action :verify_authorized, :only => :first_contact
  skip_before_action :logged_out_redirect, only: :first_contact

  # GET /devices
  # GET /devices.json
  def index
    @devices = policy_scope(Device.where(user_id: current_user.id).page(params[:page]))
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new()
    authorize @device
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    authorize @device

    match = Device.find_by( address: @device.address)
    if match && User.find(match.user_id).admin?
      #Take the device from the admin and give it to the user.
      @device = match
      success = match.update(device_params)

    elsif User.find(@device.user_id).admin
      success = @device.save
    else
      flash.now[:error] = "Incorrect MAC address."
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to @device, notice: 'Sensor was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { @device = Device.new(device_params); render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update


    respond_to do |format|
      if @device.update(device_params)
        unless params[:device][:redirect_to].blank?
          redirect_to params[:device][:redirect_to]
          return
        end
        format.html { redirect_to @device, notice: 'Sensor was successfully updated.' }
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
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Sensor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def first_contact
    @device = Device.find_by address: params[:address]

    #Don't authorize

    respond_to do |format|
      format.html {render(layout: false)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
      authorize @device
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name, :address, :notes, :experiment_id, :encryption_key).merge(user_id: current_user.id)
    end
end
