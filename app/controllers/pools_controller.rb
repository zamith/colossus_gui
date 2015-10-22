class PoolsController < ApplicationController
  def index
    @pool_groups = api.pools.all.map {|pool_group| PoolGroup.new(pool_group)}
  end
end
