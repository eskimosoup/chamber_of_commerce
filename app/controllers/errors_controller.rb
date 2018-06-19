class ErrorsController < ApplicationController
  before_action :status_code

  def show
    respond_to do |format|
      format.html do
        render status_code.to_s, status: status_code
      end
      format.all { head status_code }
    end
  end

  protected

  def status_code
    params[:code] || 500
  end
end
