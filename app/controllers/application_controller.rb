class ApplicationController < ActionController::API
  def set_model(model, params)
    model.exists?(params[:id]) ? model.find(params[:id]) : {}
  end
end
