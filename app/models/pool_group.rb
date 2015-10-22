class PoolGroup
  def initialize(pool_group_attrs)
    @pool_group_attrs = pool_group_attrs
  end

  def name
    pool_group_attrs["display_group_name"]
  end

  def pools
    pool_group_attrs["pools"].map{|pool| Pool.new(pool)}
  end

  private

  attr_reader :pool_group_attrs
end
