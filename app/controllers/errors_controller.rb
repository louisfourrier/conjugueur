class ErrorsController < ApplicationController
  def show
    flash[:notice] = "Cette page n'existe pas"
    redirect_to root_path
    
  end
end
