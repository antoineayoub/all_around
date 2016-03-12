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
