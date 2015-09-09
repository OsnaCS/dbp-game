class TradesController < ApplicationController
  before_action :set_trade, only: [:buy, :show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /trades
  # GET /trades.json
  def index
    time = DateTime.now
    Trade.all.each do |trade|
      if(time.to_i-trade.change_at.to_i>=86400) # 60*60*24 = blub Zeit in Sekunden umgerechnet auf 1 Tag Laenge
        trade.change_at = time
        trade.value = (0.6 * rand + 0.3) * trade.ressource  #ToDo: muss mit random substituiert werden
        trade.save
      end
    end


    @trades = Trade.all.order(:ressource)
  end

  # GET /trades/1
  # GET /trades/1.json
  def show
  end

  # GET /trades/new
  def new
    @trade = Trade.new
  end

  # GET /trades/1/edit
  def edit
  end

  # POST /trades
  # POST /trades.json
  def create
    @trade = Trade.new(trade_params)

    respond_to do |format|
      if @trade.save
        format.html { redirect_to @trade, notice: 'Trade was successfully created.' }
        format.json { render :show, status: :created, location: @trade }
      else
        format.html { render :new }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1
  # PATCH/PUT /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: 'Trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade }
      else
        format.html { render :edit }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trades/1
  # DELETE /trades/1.json
  def destroy
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to trades_url, notice: 'Trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def buy
    if(@trade.ressource == 1)
      buy = (params[:sell_metall].to_i * @trade.value / params[:to].to_i)
      # reduce params[:amount] from metall
    end
    if(@trade.ressource == 2)
      buy = (params[:sell_kristall].to_i * @trade.value / params[:to].to_i)
      # reduce params[:amount] from kristall
    end
    if(@trade.ressource == 4)
      buy = (params[:sell_treibstoff].to_i * @trade.value / params[:to].to_i)
      # reduce params[:amount] from treibstoff
    end
    if(params[:to] == 1)
      # add buy to metall
    end
    if(params[:to] == 2)
      # add buy to kristall
    end
    if(params[:to] == 4)
      # add buy to treibstoff
    end
    redirect_to trades_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
      @trade = Trade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_params
      params.require(:trade).permit(:trade_id, :ressource, :value)
    end
end
