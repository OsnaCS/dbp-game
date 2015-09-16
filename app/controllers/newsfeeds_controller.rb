class NewsfeedsController < ApplicationController
  before_action :set_newsfeed, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  # GET /newsfeeds
  # GET /newsfeeds.json
  def index
    @newsfeeds = Newsfeed.all
  end

  # GET /newsfeeds/1
  # GET /newsfeeds/1.json
  def show
  end

  # GET /newsfeeds/new
  def new
    @newsfeed = Newsfeed.new
  end

  # GET /newsfeeds/1/edit
  def edit
  end

  # POST /newsfeeds
  # POST /newsfeeds.json
  def create
    @newsfeed = Newsfeed.new(newsfeed_params)

    respond_to do |format|
      if @newsfeed.save
        format.html { redirect_to @newsfeed, notice: 'Newsfeed was successfully created.' }
        format.json { render :show, status: :created, location: @newsfeed }
      else
        format.html { render :new }
        format.json { render json: @newsfeed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsfeeds/1
  # PATCH/PUT /newsfeeds/1.json
  def update
    respond_to do |format|
      if @newsfeed.update(newsfeed_params)
        format.html { redirect_to @newsfeed, notice: 'Newsfeed was successfully updated.' }
        format.json { render :show, status: :ok, location: @newsfeed }
      else
        format.html { render :edit }
        format.json { render json: @newsfeed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsfeeds/1
  # DELETE /newsfeeds/1.json
  def destroy
    @newsfeed.destroy
    respond_to do |format|
      format.html { redirect_to newsfeeds_url, notice: 'Newsfeed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsfeed
      @newsfeed = Newsfeed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsfeed_params
      params.require(:newsfeed).permit(:title, :body)
    end
end
