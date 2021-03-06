class MaterialListsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_material_list, only: [:show, :edit, :update, :destroy]

  # GET /material_lists
  # GET /material_lists.json
  def index
    if user_signed_in?
      @search = MaterialList.ransack(params[:q]) #for ransack
      @material_lists = @search.result.order("created_at DESC").page(params[:page]).per(50)
    else
      redirect_to new_user_session_path
    end
  end

  def search #for ransack
    index
    render :index
  end

  # GET /material_lists/1
  # GET /material_lists/1.json
  def show
    @material_list = MaterialList.find(params[:id])
  end

  # GET /material_lists/new
  def new
    @material_list = MaterialList.new
  end

  # GET /material_lists/1/edit
  def edit
  end

  # POST /material_lists
  # POST /material_lists.json
  def create
    @material_list = MaterialList.new(material_list_params)

    respond_to do |format|
      if @material_list.save
        format.html { redirect_to @material_list, notice: 'Material list was successfully created.' }
        format.json { render :show, status: :created, location: @material_list }
      else
        format.html { render :new }
        format.json { render json: @material_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /material_lists/1
  # PATCH/PUT /material_lists/1.json
  def update
    respond_to do |format|
      if @material_list.update(material_list_params)
        format.html { redirect_to @material_list, notice: 'Material list was successfully updated.' }
        format.json { render :show, status: :ok, location: @material_list }
      else
        format.html { render :edit }
        format.json { render json: @material_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /material_lists/1
  # DELETE /material_lists/1.json
  def destroy
    @material_list.destroy
    respond_to do |format|
      format.html { redirect_to material_lists_url, notice: 'Material list was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_list
      @material_list = MaterialList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_list_params
      params.require(:material_list).permit(:project_id, :material_id, :unit_price, :quantity)
    end
end
