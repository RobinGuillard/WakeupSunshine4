class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]
  
  require 'net/http'
  require 'open-uri'
  require 'json'
  require 'time'
  require'date'

  # GET /alerts
  # GET /alerts.json
  def index
    @alerts = Alert.all
  end

  def rendre_active
    @alert = Alert.find(params[:id])
    @t = Time.now.to_i
    @date = Time.new
    @reveil = Time.new(@date.year,@date.month,@date.day, @alert.heures,@alert.minutes, 0).to_time.to_i
    
    @tempsquireste = @reveil - @t
    if @tempsquireste < -60
      @tempsquireste = @tempsquireste + 60*60*60*24
    end

    @lieu = @alert.lieu
    @data = JSON.load(open("http://api.openweathermap.org/data/2.5/weather?q=" + @lieu + ",fr&appid=2de143494c0b295cca9337e1e96b00e0"))
    #, :proxy => "http://kuzh.polytechnique.fr:8080"
    @weather = @data["weather"][0]["main"]

      #@t.to_time.to_i
    if !@alert.active
      @alert.update_attribute :active, true
      if @tempsquireste < 0
        if @weather == "clear"
          render text: "driiiiiiiing!!!"
        else
          render text: "Ne te réveille pas demain, le descriptif du temps est: " + @weather
        end  
      else
        render text: "il reste " + @tempsquireste.to_s + " secondes avant ton reveil, sweet dreams O:-)"
      end
    else
      if @tempsquireste < 0
        if @weather == "Clear"
          render text: "driiiiiiiing!!!"
        else
          render text: "Ne te réveille pas demain, le descriptif du temps est: " + @weather
        end
        
      else
        render text: "il reste " + @tempsquireste.to_s + " secondes avant ton reveil, sweet dreams O:-)"
      end
    end
  end

  def fait_il_beau
    @alert = Alert.find(params[:id])
    @lieu = @alert.lieu

    #hash = JSON.parse("http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=bd82977b86bf27fb59a04b61b657fb6f")
    
   #content = open("https://api.github.com").read
   # ancienne direction dans la view du bouton fait-il-beau : #http://api.openweathermap.org/data/2.5/weather?q=" + alert.lieu + ",fr&appid=2de143494c0b295cca9337e1e96b00e0"
    @data = JSON.load(open("http://api.openweathermap.org/data/2.5/weather?q=" + @lieu + ",fr&appid=2de143494c0b295cca9337e1e96b00e0"))
    #, :proxy => "http://kuzh.polytechnique.fr:8080"
    @try = @data["weather"][0]["main"] #bien se souvenir: il y a des crochets autour de weather du coup c'est un tableau, du coup il faut mettre [0] pour rentrer dedans
    render text: @try
    #@source = "http://api.openweathermap.org/data/2.5/weather?q=" + @lieu + ",fr&appid=2de143494c0b295cca9337e1e96b00e0"
    #resp = Net::HTTP.get_response(URI.parse(@source))
  end
#

  # GET /alerts/1
  # GET /alerts/1.json
  def show
  end

  # GET /alerts/new
  def new
    @alert = Alert.new
  end

  # GET /alerts/1/edit
  def edit
  end

  # POST /alerts
  # POST /alerts.json
  def create
    @alert = Alert.new(alert_params)

    respond_to do |format|
      if @alert.save
        format.html { redirect_to @alert, notice: 'Alert was successfully created.' }
        format.json { render :show, status: :created, location: @alert }
      else
        format.html { render :new }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alerts/1
  # PATCH/PUT /alerts/1.json
  def update
    respond_to do |format|
      if @alert.update(alert_params)
        format.html { redirect_to @alert, notice: 'Alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @alert }
      else
        format.html { render :edit }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to alerts_url, notice: 'Alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_params
      params.require(:alert).permit(:heures, :minutes, :lieu, :active)
    end
end
