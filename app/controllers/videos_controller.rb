class VideosController < ApplicationController
  def show
    @user = current_user
    @subscription = Subscription.first
  end
end
