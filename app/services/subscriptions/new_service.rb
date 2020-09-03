module Subscriptions
  class NewService
    def initialize
    end

    def call
      Subscription.create(name: 'PREMIUM', price_cents: '300', sku: 'premium')
    end
  end
end
