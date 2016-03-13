class RequestsController < ApplicationController

  def index

   @request = Request.new
   @requests = current_user.requests.select do |request|
      request.persisted?
   end
   @requests.sort_by! &:created_at
  end

  def tickets
    # We then listed not assigned
    if current_user.category == "volunteer"
      @solved_tickets = current_user.tickets.where(status: "solved")
      @pending_tickets = current_user.tickets.where(status: "pending")
      @not_assigned_tickets = Request.where(status: "not_assigned")
    else
      redirect_to requests_path
    end
  end

  def create
    @request = Request.new(request_params)
    @request.refugee = current_user
    @request.status = 'not assigned'
    if @request.save
      respond_to do |format|
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
