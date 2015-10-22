class TicketGroup
  def initialize(ticket_group_attrs)
    @ticket_group_attrs = ticket_group_attrs
  end

  def total
    ticket_group_attrs["total_items"]
  end

  def items
    ticket_group_attrs["items"].map{|ticket| Ticket.new(ticket)}
  end

  private

  attr_reader :ticket_group_attrs
end
