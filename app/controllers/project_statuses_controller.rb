class ProjectStatusesController < ApplicationController
  load_and_authorize_resource 
  before_action :set_project_status, only: [:show, :edit, :update, :destroy]

  # GET /project_statuses
  # GET /project_statuses.json
  def index
    if user_signed_in?
      @search = ProjectStatus.ransack(params[:q]) #for ransack
      @project_statuses = @search.result.order("created_at DESC").page(params[:page]).per(50)
    else
      redirect_to new_user_session_path
    end
  end

  def search #for ransack
    index
    render :index
  end

  # GET /project_statuses/1
  # GET /project_statuses/1.json
  def show
  end

  # GET /project_statuses/new
  def new
    @project_status = ProjectStatus.new
  end

  # GET /project_statuses/1/edit
  def edit
  end

  # POST /project_statuses
  # POST /project_statuses.json
  def create
    @project_status = ProjectStatus.new(project_status_params)

    respond_to do |format|
      if @project_status.save
        format.html { redirect_to project_statuses_url, notice: 'Project status was successfully created.' }
        format.json { render :show, status: :created, location: @project_status }
      else
        format.html { render :new }
        format.json { render json: @project_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_statuses/1
  # PATCH/PUT /project_statuses/1.json
  def update
    respond_to do |format|
      if @project_status.update(project_status_params)
        format.html { redirect_to @project_status, notice: 'Project status was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_status }
      else
        format.html { render :edit }
        format.json { render json: @project_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_statuses/1
  # DELETE /project_statuses/1.json
  def destroy
    @project_status.destroy
    respond_to do |format|
      format.html { redirect_to project_statuses_url, notice: 'Project status was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_status
      @project_status = ProjectStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_status_params
      params.require(:project_status).permit(:project_status_description)
    end
end
