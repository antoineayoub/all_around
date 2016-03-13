class RequestsController < ApplicationController

  def index
    if current_user.category == "volunteer"
      @not_assigned_requests = Request.where(status: "not_assigned")
      @pending_requests = current_user.tickets.where(status: 'pending')
      @solved_requests = current_user.tickets.where(status: 'solved')
    else
      @not_assigned_requests = current_user.requests.where(status: "not_assigned")
      @pending_requests = current_user.requests.where(status: 'pending')
      @solved_requests = current_user.requests.where(status: 'solved')
    end
  end

  def new
    @category = params[:category]
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.refugee = current_user
    if @request.save
      redirect_to requests_path
    else
      @category = params[:request][:category]
      render :new
    end
  end

  private
  def request_params
    params.require(:request).permit(:content, :category)
  end

end
