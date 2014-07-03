class PagesController < ApplicationController
  force_ssl unless Rails.env.development? || Rails.env.test?
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  skip_before_action :logged_out_redirect #Causes infinite loop if not disabled

  before_action :set_page, only: [:show, :edit, :update, :destroy]
  def home
  end

  def faq
    @page = Page.find_by(title: "FAQ")
    render 'show'
  end

  def buy
    @page = Page.find_by(title: "Buy")
    render 'show'
  end


    # GET /pages
  def index
    @pages = policy_scope Page.all.page(params[:page])

    respond_to do |format|
      format.html
      format.csv {         send_data( @pages.to_csv,
          filename: "CO2_datapoints_#{Time.zone.now}.csv", 
          disposition: 'inline', type: "multipart/related")
      }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
    authorize @page
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create

     #Can also be created with:
     # => curl -X POST -H "Content-Type: application/json; charset=UTF-8" -d '{"page": {"ppm": "400","device_id": "1"}}' localhost:3000/pages.json
     # => curl -X POST -H "Content-Type: application/json; charset=UTF-8" -d '{"page": {"ppm": "400", "device_address": "42"}}' localhost:3000/pages.json

    @page = Page.new(page_params)
    authorize @page

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Sensor datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Sensor datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      if(params.has_key? :id)
        @page = Page.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :long_title, :content)
    end


end
