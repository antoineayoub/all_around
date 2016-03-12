class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to requests_path
    else
      render :new
    end
  end

  private
  def request_params
    params.require(:request).permit(:content, :category)
  end

end
