class OrdersController < ApplicationController
  def create
    subscription = Subscription.find(params[:subscription_id])
    order        = Order.create!(subscription: subscription,
                                 subscription_sku: subscription.sku,
                                 amount: subscription.price,
                                 state: 'pending',
                                 user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: subscription.sku,
        amount: subscription.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
    @state = 'EN ATTENTE' if @order.state == 'pending'
    @state = 'CONFIRMÉ'   if @order.state == 'paid'
  end
end
