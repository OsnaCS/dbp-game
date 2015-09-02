class RanksController < ApplicationController
  before_action :set_rank, only: [:show, :edit, :update, :destroy]

  # GET /ranks
  # GET /ranks.json
  def index
    @ranks = Rank.all
  end

  # GET /ranks/1
  # GET /ranks/1.json
  def show
  end

  # GET /ranks/new
  def new
    @rank = Rank.new
  end

  # GET /ranks/1/edit
  def edit
  end

	#GET ksdflsdkflöskfsd
	def self.rankList(pos, offset)
		displayed_ranks = Array.new

		currentRank = nil
		User.all.each do |u|
			currentRank = Rank.find_by(user_id: u.id)

			if(currentRank)
			else
				currentRank = Rank.new
				currentRank.user_id = u.id
				currentRank.score = 0
				Rank.create(:user_id => u.id, :score => 0)
			end
			displayed_ranks << currentRank
		end
		displayed_ranks = displayed_ranks.sort_by{|rank| rank.score}.reverse

		if(pos < 0)
			pos = 0
		end
		
		if(offset < 0)
			offset = 0
		end

		lower = pos - offset
		if(lower < 0)
			lower = 0
    end
		upper = pos + offset
    
		if(upper >= displayed_ranks.length)
			upper = displayed_ranks.length - 1
		end

		rankedNames = Hash.new("Default")

		counter = lower
		displayed_ranks[lower..upper].each do |a|
			counter = counter + 1
			rankedNames[a] = counter
    end

		return rankedNames
	end

  # POST /ranks
  # POST /ranks.json
  def create
    @rank = Rank.new(rank_params)

    respond_to do |format|
      if @rank.save
        format.html { redirect_to @rank, notice: 'Rank was successfully created.' }
        format.json { render :show, status: :created, location: @rank }
      else
        format.html { render :new }
        format.json { render json: @rank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ranks/1
  # PATCH/PUT /ranks/1.json
  def update
    respond_to do |format|
      if @rank.update(rank_params)
        format.html { redirect_to @rank, notice: 'Rank was successfully updated.' }
        format.json { render :show, status: :ok, location: @rank }
      else
        format.html { render :edit }
        format.json { render json: @rank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranks/1
  # DELETE /ranks/1.json
  def destroy
    @rank.destroy
    respond_to do |format|
      format.html { redirect_to ranks_url, notice: 'Rank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rank
      @rank = Rank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rank_params
      params.require(:rank).permit(:user_id, :score)
    end
end
