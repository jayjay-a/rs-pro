class RentalListsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_rental_list, only: [:show, :edit, :update, :destroy]

  # GET /rental_lists
  # GET /rental_lists.json
  def index
    if user_signed_in?
      @search = RentalList.ransack(params[:q]) #for ransack
      @rental_lists = @search.result.order("created_at DESC").page(params[:page]).per(50)
    else
      redirect_to new_user_session_path
    end
  end

  def search #for ransack
    index
    render :index
  end

  # GET /rental_lists/1
  # GET /rental_lists/1.json
  def show
    @rental_list = RentalList.find(params[:id])
  end

  # GET /rental_lists/new
  def new
    @rental_list = RentalList.new
  end

  # GET /rental_lists/1/edit
  def edit
  end

  # POST /rental_lists
  # POST /rental_lists.json
  def create
    @rental_list = RentalList.new(rental_list_params)

    respond_to do |format|
      if @rental_list.save
        format.html { redirect_to @rental_list, notice: 'Rental list was successfully created.' }
        format.json { render :show, status: :created, location: @rental_list }
      else
        format.html { render :new }
        format.json { render json: @rental_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rental_lists/1
  # PATCH/PUT /rental_lists/1.json
  def update
    respond_to do |format|
      if @rental_list.update(rental_list_params)
        format.html { redirect_to @rental_list, notice: 'Rental list was successfully updated.' }
        format.json { render :show, status: :ok, location: @rental_list }
      else
        format.html { render :edit }
        format.json { render json: @rental_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rental_lists/1
  # DELETE /rental_lists/1.json
  def destroy
    @rental_list.destroy
    respond_to do |format|
      format.html { redirect_to rental_lists_url, notice: 'Rental list was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental_list
      @rental_list = RentalList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_list_params
      params.require(:rental_list).permit(:project_id, :rental_equipment_id, :rental_price, :cost_frequency)
    end
end
