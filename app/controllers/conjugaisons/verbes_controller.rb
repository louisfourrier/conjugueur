module Conjugaisons
  class VerbesController < ApplicationController
    before_action :set_verb, only: [:show, :edit, :update, :destroy]
    before_filter :no_access, only:[:edit, :new, :create, :destroy]
    # GET /verbs
    # GET /verbs.json
    def index
      letter = params[:starting_letter]
      number = params[:number_letter]
      if letter.nil?
        @letter = nil
      else
        @letter = letter.to_s.downcase
      end

      @verbs = Verb.where('content ilike ? or research_name ilike ?', "#{@letter}%", "#{@letter}%").order('content').paginate(:page => params[:page], :per_page => 100)
      respond_to do |format|
        format.html
        format.js
      end
    end

    def autocomplete
      name = params[:term].to_s.downcase
      verbs1 = Verb.where("content ilike ? or research_name ilike ?", "#{name}%", "#{name}%").limit(10).pluck(:content)
      if verbs1.size < 6
        verbs2 = Verb.where("content ilike ? or research_name ilike ?", "%#{name}%", "%#{name}%").limit(10).pluck(:content)
      else
      verbs2 = []
      end
      verbs = verbs1 + verbs2
      @verbs = verbs.uniq
      render json: @verbs.to_json
    end

    def search
      @name = params[:verb].to_s.downcase
      @verb = Verb.find_by_content(@name) || Verb.find_by_research_name(I18n.transliterate(@name))
      if !@verb.nil?
        redirect_to conjugaisons_verbe_path(@verb)
      else
        @verbs = Verb.similar_verbs(@name)
      end
    end

    # GET /verbs/1
    # GET /verbs/1.json
    def show
      
    end

    # GET /verbs/new
    def new
      @verb = Verb.new
    end

    # GET /verbs/1/edit
    def edit
    end

    # POST /verbs
    # POST /verbs.json
    def create
      @verb = Verb.new(verb_params)

      respond_to do |format|
        if @verb.save
          format.html { redirect_to @verb, notice: 'Verb was successfully created.' }
          format.json { render :show, status: :created, location: @verb }
        else
          format.html { render :new }
          format.json { render json: @verb.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /verbs/1
    # PATCH/PUT /verbs/1.json
    def update
      respond_to do |format|
        if @verb.update(verb_params)
          format.html { redirect_to @verb, notice: 'Verb was successfully updated.' }
          format.json { render :show, status: :ok, location: @verb }
        else
          format.html { render :edit }
          format.json { render json: @verb.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /verbs/1
    # DELETE /verbs/1.json
    def destroy
      @verb.destroy
      respond_to do |format|
        format.html { redirect_to verbs_url, notice: 'Verb was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_verb
      @verb = Verb.includes(:tense_entries).friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verb_params
      params.require(:verb).permit(:content, :group, :employ, :auxiliary, :definition)
    end
  end
end
