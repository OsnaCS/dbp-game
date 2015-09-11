class BuildListsController < ApplicationController
  before_action :set_build_list, only: [:show, :edit, :update, :destroy]

  # GET /build_lists
  # GET /build_lists.json
  def index
    @build_lists = BuildList.all
  end

  # GET /build_lists/1
  # GET /build_lists/1.json
  def show
  end

  # GET /build_lists/new
  def new
    @build_list = BuildList.new
  end

  # GET /build_lists/1/edit
  def edit
  end

  # POST /build_lists
  # POST /build_lists.json
  def create
    @build_list = BuildList.new(build_list_params)

    respond_to do |format|
      if @build_list.save
        format.html { redirect_to @build_list, notice: 'Build list was successfully created.' }
        format.json { render :show, status: :created, location: @build_list }
      else
        format.html { render :new }
        format.json { render json: @build_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /build_lists/1
  # PATCH/PUT /build_lists/1.json
  def update
    respond_to do |format|
      if @build_list.update(build_list_params)
        format.html { redirect_to @build_list, notice: 'Build list was successfully updated.' }
        format.json { render :show, status: :ok, location: @build_list }
      else
        format.html { render :edit }
        format.json { render json: @build_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_lists/1
  # DELETE /build_lists/1.json
  def destroy
    @build_list.destroy
    respond_to do |format|
      format.html { redirect_to build_lists_url, notice: 'Build list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build_list
      @build_list = BuildList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_list_params
      params[:build_list]
    end
end
