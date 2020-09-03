class ArticlesController < ApplicationController
  def index
    @user = current_user
    articles_brut = []
    @user.topics.each do |topic|
      topic = Topic.find_by(name: topic)
      Article.where(topic_id: topic.id).each { |article| articles_brut << article }
    end
    redirect_to edit_topics_path if articles_brut.empty?
    articles_brut.shuffle!

    if @user.orders.where(state: 'paid').empty?
      @articles = articles_brut.first(3)
      @premium_articles = articles_brut - @articles
    else
      @articles = articles_brut
      @premium_articles = []
    end
  end

  def show
    @articles = Article.all
    @article = Article.find(params[:id])
  end
end
