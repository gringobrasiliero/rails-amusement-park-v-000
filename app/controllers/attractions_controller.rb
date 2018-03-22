class AttractionsController < ApplicationController
  before_action :get_attraction, only: [:show, :edit, :update, :destroy]

  # GET /attractions
  # GET /attractions.json
  def index
    @user = current_user
  end

  # GET /attractions/1
  # GET /attractions/1.json
  def show
    @attraction = Attraction.find(params[:id])
    @user = current_user
  end

  # GET /attractions/new
  def new
    @attraction = Attraction.new
  end

  # GET /attractions/1/edit
  def edit
    get_attraction
  end

  def ride
    get_attraction
    @user = User.find(session[:user_id])
      ride = Ride.new(user_id: session[:user_id], attraction_id: params[:id])
    if ride.take_ride == true
      flash[:message] = "Thanks for riding the #{@attraction.name}!"
    else
      flash[:message] = ride.take_ride
    end
      redirect_to user_path(@user)
    end
  # POST /attractions
  # POST /attractions.json
  def create
    @attraction = Attraction.new(attraction_params)

    respond_to do |format|
      if @attraction.save
        format.html { redirect_to @attraction, notice: 'Attraction was successfully created.' }
        format.json { render :show, status: :created, location: @attraction }
      else
        format.html { render :new }
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attractions/1
  # PATCH/PUT /attractions/1.json
  def update
    respond_to do |format|
      if @attraction.update(attraction_params)
        format.html { redirect_to @attraction, notice: 'Attraction was successfully updated.' }
        format.json { render :show, status: :ok, location: @attraction }
      else
        format.html { render :edit }
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attractions/1
  # DELETE /attractions/1.json
  def destroy
    @attraction.destroy
    respond_to do |format|
      format.html { redirect_to attractions_url, notice: 'Attraction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def get_attraction
      @attraction = Attraction.find(params[:id])
      end
    # Never trust parameters from the scary internet, only allow the white list through.
    def attraction_params
     params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height )
    end
end
