class RequestsController < ApplicationController

  def index
   @request = Request.new
   @requests = current_user.requests.select do |request|
      request.persisted?
   end
  end

  def create
    @request = Request.new(request_params)
    @request.refugee = current_user
    @request.status = 'not assigned'
    raise
    if @request.save
      respond_to do |format|
        raise
        format.html { redirect_to requests_path }
        format.js
      end
    else
      respond_to do |format|
        @category = params[:request][:category]
        format.html { render requests_path }
        format.js  # <-- idem
      end
    end
  end

  private

  def request_params
    params.require(:request).permit(:content, :category)
  end
end
