class ExperimentsController < ApplicationController
  before_action :set_experiment, only: [:show, :edit, :update, :destroy]

  # GET /experiments
  # GET /experiments.json
  def index
    @experiments = Experiment.all
  end

  # GET /experiments/1
  # GET /experiments/1.json
  def show
    @chart_data = {}
    @chart_ykeys = '['
    @chart_labels = {}

    @experiment.sensor_data.each do |datum|
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
    @chart_ykeys = @chart_ykeys[0..-3]
    @chart_ykeys << ']'

    #@chart_data = { '2006' => { a: 100, b: 90 },
    #                '2007' => { a: 75,  b: 65 }
    #              }
    #@chart_ykeys = "['id_num_a', 'id_num_b']"
    #@chart_labels = {'A' => true, 'B' => true}

=begin
    @chart_options = []

          #Probably very slow
    @experiment.devices.each do |device|
      device_data = []
      
      data = SensorDatum.where(:device_id => device.id, :experiment_id => @experiment.id)
      data.each do |datum|
        device_data << [datum.created_at.to_i, datum.ppm]
      end

      @chart_options << {label: device.name, data: device_data}
    end
=end
  end

  # GET /experiments/new
  def new
    @experiment = Experiment.new
  end

  # GET /experiments/1/edit
  def edit
  end

  # POST /experiments
  # POST /experiments.json
  def create
    @experiment = Experiment.new(experiment_params)

    respond_to do |format|
      if @experiment.save
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
      if @experiment.update(experiment_params)
        format.html { redirect_to @experiment, notice: 'Experiment was successfully updated.' }
        format.json { render :show, status: :ok, location: @experiment }
      else
        format.html { render :edit }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_experiment
      @experiment = Experiment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiment_params
      params.require(:experiment).permit(:name, :location, :start, :end)
    end
end
