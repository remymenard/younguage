class ArticlesController < ApplicationController
  def index
    @user = current_user
    articles_brut = []
    @user.topics.each do |topic|
      topic = Topic.find_by(name: topic)
      # VRAI ALGO
      # Article.where(topic_id: topic.id).each { |article| articles_brut << article }

      #  ALGO FAKE POUR LE PITCH
      articles_brut << Article.where(topic_id: topic.id).first
    end
    @user.topics.each do |topic|
      topic = Topic.find_by(name: topic)
      # VRAI ALGO
      # Article.where(topic_id: topic.id).each { |article| articles_brut << article }

      #  ALGO FAKE POUR LE PITCH
      Article.where(topic_id: topic.id).each { |article| articles_brut << article }
    end
    redirect_to edit_topics_path if articles_brut.empty?
    index = 2
    hold = articles_brut.delete_at(index)
    articles_brut.shuffle.insert(index, hold)
    # articles_brut.shuffle!

    if @user.orders.where(state: 'paid').empty?
      @articles = articles_brut.first(3)
      @premium_articles = articles_brut - @articles
    else
      @articles = articles_brut
      @premium_articles = []
    end
    @video = Video.first


  end

  def show
    @articles = Article.all
    @article = Article.find(params[:id])
    @subscription = Subscription.first
    @user = current_user
  end
end
