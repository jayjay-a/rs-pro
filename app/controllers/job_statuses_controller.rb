class JobStatusesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_job_status, only: [:show, :edit, :update, :destroy]

  # GET /job_statuses
  # GET /job_statuses.json
  def index
    if user_signed_in?
      @search = JobStatus.ransack(params[:q]) #for ransack
      @job_statuses = @search.result.order("created_at DESC").page(params[:page]).per(50)
    else
      redirect_to new_user_session_path
    end
  end

  def search #for ransack
    index
    render :index
  end


  # GET /job_statuses/1
  # GET /job_statuses/1.json
  def show
  end

  # GET /job_statuses/new
  def new
    @job_status = JobStatus.new
  end

  # GET /job_statuses/1/edit
  def edit
  end

  # POST /job_statuses
  # POST /job_statuses.json
  def create
    @job_status = JobStatus.new(job_status_params)

    respond_to do |format|
      if @job_status.save
        format.html { redirect_to job_statuses_url, notice: 'Job status was successfully created.' }
        format.json { render :show, status: :created, location: @job_status }
      else
        format.html { render :new }
        format.json { render json: @job_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_statuses/1
  # PATCH/PUT /job_statuses/1.json
  def update
    respond_to do |format|
      if @job_status.update(job_status_params)
        format.html { redirect_to @job_status, notice: 'Job status was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_status }
      else
        format.html { render :edit }
        format.json { render json: @job_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_statuses/1
  # DELETE /job_statuses/1.json
  def destroy
    @job_status.destroy
    respond_to do |format|
      format.html { redirect_to job_statuses_url, notice: 'Job status was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_status
      @job_status = JobStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_status_params
      params.require(:job_status).permit(:job_status_description)
    end
end
