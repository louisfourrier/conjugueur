class HomeController < ApplicationController
  
  def main
  end
  
  def recherche_verbe
    if params[:verb]
      verb = params[:verb].to_s
      @verbs = TenseEntry.search_verb(verb)
    else
      @verbs = []
    end
  end
end
