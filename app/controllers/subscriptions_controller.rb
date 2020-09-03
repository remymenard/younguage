class SubscriptionsController < ApplicationController
  def index
    @subscription = Subscription.first
  end
end
