class TenseEntriesController < ApplicationController
  before_action :set_tense_entry, only: [:show, :edit, :update, :destroy]
  before_filter :no_access

  # GET /tense_entries
  # GET /tense_entries.json
  def index
    @tense_entries = TenseEntry.all
  end

  # GET /tense_entries/1
  # GET /tense_entries/1.json
  def show
  end

  # GET /tense_entries/new
  def new
    @tense_entry = TenseEntry.new
  end

  # GET /tense_entries/1/edit
  def edit
  end

  # POST /tense_entries
  # POST /tense_entries.json
  def create
    @tense_entry = TenseEntry.new(tense_entry_params)

    respond_to do |format|
      if @tense_entry.save
        format.html { redirect_to @tense_entry, notice: 'Tense entry was successfully created.' }
        format.json { render :show, status: :created, location: @tense_entry }
      else
        format.html { render :new }
        format.json { render json: @tense_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tense_entries/1
  # PATCH/PUT /tense_entries/1.json
  def update
    respond_to do |format|
      if @tense_entry.update(tense_entry_params)
        format.html { redirect_to @tense_entry, notice: 'Tense entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @tense_entry }
      else
        format.html { render :edit }
        format.json { render json: @tense_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tense_entries/1
  # DELETE /tense_entries/1.json
  def destroy
    @tense_entry.destroy
    respond_to do |format|
      format.html { redirect_to tense_entries_url, notice: 'Tense entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tense_entry
      @tense_entry = TenseEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tense_entry_params
      params.require(:tense_entry).permit(:total_content, :begin_content, :important_content, :order, :verb_id, :tense_id)
    end
end
