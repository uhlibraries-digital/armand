class ErrorController < ApplicationController

  def missing 
    render :status => 404
  end

  def internalerror
    render :status => 500
  end
  
end