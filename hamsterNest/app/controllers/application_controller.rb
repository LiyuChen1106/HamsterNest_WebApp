class ApplicationController < ActionController::Base
  def show
    render params[:page]
  end
end
