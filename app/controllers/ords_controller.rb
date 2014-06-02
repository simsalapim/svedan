class OrdsController < ApplicationController
  before_action :set_ord, only: [:show, :edit, :update, :destroy, :attempt]

  # GET /ords
  # GET /ords.json
  def index
    @ords = Ord.question_order
    @ord = Ord.new
  end

  def quiz
  end

  # GET /ords/1
  # GET /ords/1.json
  def show
  end

  # GET /ords/new
  def new
    @ord = Ord.new
  end

  # GET /ords/1/edit
  def edit
  end

  # POST /ords
  # POST /ords.json
  def create
    @ord = Ord.new(ord_params)

    respond_to do |format|
      if @ord.save
        format.html { render @ord }
      else
        format.html { render action: new }
        format.json { render json: @ord.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ords/1
  # PATCH/PUT /ords/1.json
  def update
    respond_to do |format|
      if @ord.update(ord_params)
        format.html { redirect_to @ord, notice: 'Ordet har uppdaterats!.' }
        format.json { head :no_content }
      else
        format.html { render action: 'Redigera' }
        format.json { render json: @ord.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ords/1
  # DELETE /ords/1.json
  def destroy
    @ord.destroy
    respond_to do |format|
      format.html { redirect_to ords_url }
      format.json { head :no_content }
    end
  end

  def next_question
    @ord = Ord.next_question
    respond_to do |format|
      format.html { render @ord }
      format.json { render :json => @ord }
    end
  end

  def attempt
    @attempt = @ord.attempt(params[:answer])
    render :status => :error unless @attempt.persisted?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ord
      @ord = Ord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ord_params
      params.require(:ord).permit(:english, :swedish, :answer)
    end
end
