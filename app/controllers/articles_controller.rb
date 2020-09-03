class ArticlesController < ApplicationController
  def index
    @articles = []
    @user = current_user
    @user.topics.each do |topic|
      topic = Topic.find_by name: topic
      Article.where(topic_id: topic.id).each { |article| @articles << article }
    end
    redirect_to edit_topics_path if @articles.empty?
    @articles.shuffle!
  end

  def show
    @articles = Article.all
    @article = Article.find(params[:id])
  end
end
