class TicketsController < ApplicationController
  def index
    @ticket_group = TicketGroup.new(api.tickets.all(customer_id: customer_id))
  end

  def new
    @ticket = Ticket.new
  end

  def create
    api_response = api.tickets.create(ticket_params)
    if api_response.has_key?("error") || api_response.has_key?("errors")
      flash[:error] = api_response
    else
      flash[:notice] = "Created ticket"
    end
    redirect_to tickets_path
  end

  private

  def ticket_params
    params.require(:ticket)
      .permit(:pool_id, :selections, :stake, :cost)
      .merge(customer_id: customer_id, currency: "GBP", poc: "GB")
  end
end
