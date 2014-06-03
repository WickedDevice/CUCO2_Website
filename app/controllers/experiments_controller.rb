class ExperimentsController < ApplicationController
  before_action :set_experiment, only: [:show, :edit, :update, :destroy]
  # GET /experiments
  # GET /experiments.json
  def index
    @experiments = Experiment.all
    respond_to do |format|
      format.html
      format.csv { render text: @experiments.to_csv}
    end
  end

  # GET /experiments/1
  # GET /experiments/1.json
  def show
    @chart_data = {}
    @chart_ykeys = '['
    @chart_labels = {}

    #Loads the last 1000 data points into the graph.
    # This code smells and probably should change.
    range = [-1000, -1*@experiment.sensor_data.length].max() .. -1

    @experiment.sensor_data[range].each do |datum|

      if @chart_data[datum.created_at].nil?
        @chart_data[datum.created_at] = { datum.device.id => datum.ppm }
      else
        @chart_data[datum.created_at][datum.device.id] = datum.ppm
      end

      unless @chart_labels.has_key? datum.device.name
        @chart_ykeys << "'id_num_" + datum.device.id.to_s + "', "
        @chart_labels[datum.device.name] = true
      end

    end
    @chart_ykeys = @chart_ykeys[0..-3] unless @chart_ykeys.length < 4
    @chart_ykeys << ']'

    respond_to do |format|
      format.html
      format.csv {
        render text: @experiment.to_csv
        return
      }
    end
  end

  # GET /experiments/new
  def new
    @experiment = Experiment.new
    @devices = Device.all
  end

  # GET /experiments/1/edit
  def edit
  end

  # POST /experiments
  # POST /experiments.json
  def create
    @experiment = Experiment.new(experiment_params)
    success = @experiment.save
    edit_helper()

    success &= @experiment.save

    respond_to do |format|
      
      if success
        format.html { redirect_to @experiment, notice: 'Experiment was successfully created.' }
        format.json { render :show, status: :created, location: @experiment }
      else
        format.html { render :new }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiments/1
  # PATCH/PUT /experiments/1.json
  def update
    respond_to do |format|

      edit_helper()

      updated = @experiment.update(experiment_params)

      if updated
        format.html { redirect_to @experiment, notice: 'Experiment was successfully updated.' }
        format.json { render :show, status: :ok, location: @experiment }
      else
        format.html { render :edit, notice: 'Unable to update experiment.' }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiments/1
  # DELETE /experiments/1.json
  def destroy
    @experiment.destroy
    respond_to do |format|
      format.html { redirect_to experiments_url, notice: 'Experiment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def edit_helper
      #Deals with special cases in forms

      @experiment.request_only_devices(params[:experiment][:device_ids])

      if params[:experiment][:start] == "now"
        @experiment.checkout_devices()
        params[:experiment][:start] = Time.now
      end

      if params[:experiment][:end] == "now"
        @experiment.checkin_devices()
        params[:experiment][:end] = Time.now
      end

      if params[:experiment][:checkout] =="all"
        @experiment.checkout_devices()
      elsif params[:experiment][:checkout]=="none"
        @experiment.checkin_devices()
      end

      #This code smells a bit...
      if params[:experiment][:device_experiments_locs]
        params[:experiment][:device_experiments_locs].each do |de_id, location|
          if de_id == "new" #Adds a location to the newly created device_experiment(s)
            params[:experiment][:device_experiments_locs][:new].each do |device_id, new_location|
              if de = DeviceExperiment.find_by(device_id: device_id, experiment_id: @experiment.id)
                de.location = new_location
                de.save
              end
            end
          else
            de = DeviceExperiment.find(de_id)
            de.location = location
            de.save
          end
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_experiment
      @experiment = Experiment.find(params[:id])
      @devices = Device.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiment_params
      params.require(:experiment).permit(:name, :location, :start, :end,
        {:device_ids => []}, :co2_cutoff)
    end
end
