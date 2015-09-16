class FightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fight, only: [:show, :edit, :update, :destroy]
  
def index
    @target = User.find_by(:id => params[:user_id])
    @fights = Fight.all
    @fights_attacks = Fight.where(attacker: User.last)
    @fights_defends = Fight.where(defender: User.last)
  end


  # GET /fights/1
  # GET /fights/1.json
  def show
    
    @defender=@fight.defender.username
    @attacker=@fight.attacker.username
    @report = @fight.report.tr('"', '').tr(']', '').split("[").reject {|r| r.empty?} 
    @report.pop
    @report_start = @report[0].split(',').reject {|r| r.empty?}
    @report.shift
    @spy_report = @fight.spy_report.tr('"','').tr('[','').tr(']','').split('|').reject {|r| r.empty?} 
    @spy_start = @spy_report[0].tr(',','') 
    @spy_report.shift
    @first = Unit.count -1
    @second = Facility.count + 2 * @first + 1
  end

  # GET /fights/new
  def new
    @fight = Fight.new
  end

  # GET /fights/1/edit
  def edit
  end

  # POST /fights
  # POST /fights.json
  def create
    @fight = Fight.new(fight_params)

    respond_to do |format|
      if @fight.save
        format.html { redirect_to @fight, notice: 'Fight was successfully created.' }
        format.json { render :show, status: :created, location: @fight }
      else
        format.html { render :new }
        format.json { render json: @fight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fights/1
  # PATCH/PUT /fights/1.json
  def update
    respond_to do |format|
      if @fight.update(fight_params)
        format.html { redirect_to @fight, notice: 'Fight was successfully updated.' }
        format.json { render :show, status: :ok, location: @fight }
      else
        format.html { render :edit }
        format.json { render json: @fight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fights/1
  # DELETE /fights/1.json
  def destroy
    @fight.destroy
    respond_to do |format|
      format.html { redirect_to fights_url, notice: 'Fight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fight
      @fight = Fight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fight_params
      params.require(:fight).permit(:report, :time, :attacker_id, :defender_id)
    end
end
