class TopicsController < ApplicationController
  def edit
    @user = current_user
    @topics = @user.topics
  end

  def post
    @user = current_user
    selected_params = Topic::NAMES.select do |name|
      params[name.downcase] == "true"
    end
    @user.topics = selected_params
    @user.save!
    redirect_to articles_path
  end
end
