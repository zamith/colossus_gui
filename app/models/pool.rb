class Pool
  def initialize(pool_attrs)
    @pool_attrs = pool_attrs
  end

  def method_missing(name)
    if pool_attrs.has_key?(name.to_s)
      return pool_attrs[name.to_s]
    end
  end

  private

  attr_reader :pool_attrs
end
