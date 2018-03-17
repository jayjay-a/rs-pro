class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:customer_id, :project_status_id, :project_type_id, :project_start_date, :project_end_date, :bid_submit_date, :bid_material_cost, :bid_cost_of_labor, :bid_cost_of_permits, :bid_equipment_rental, :bid_freight, :tax_rate, :bid_amount, 
                                      jobs_attributes:[:id, :job_id, :project_id, :job_type_id, :job_status_id, :job_start_date, :job_end_date, :_destroy, 
                                                        tasks_attributes:[:id, :task_id, :job_id, :task_status_id, :task_start_date, :task_end_date, :task_description, :_destroy]
                                                      ],
                                      project_notes_attributes:[:id, :project_note_id, :project_notes, :project_note_date, :note_owner]
                                      )
    end
end
