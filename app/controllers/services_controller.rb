class ServicesController < ApplicationController
  before_action :set_service, only: %i[ show edit update destroy ]

  def index
    @search = Service.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @services = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @service
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = Service.new(service_params)
    @service.save!

    respond_to do |format|
      format.html { redirect_to @service, notice: 'Service was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @service.update!(service_params)
    respond_to do |format|
      format.html { redirect_to @service, notice: 'Service was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name)
    end
end
