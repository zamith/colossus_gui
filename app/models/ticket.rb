class Ticket
  include ActiveModel::Model
  attr_accessor :pool_id, :selections, :stake, :cost

  def initialize(ticket_attrs = {})
    @ticket_attrs = ticket_attrs
  end

  private

  attr_reader :ticket_attrs
end
