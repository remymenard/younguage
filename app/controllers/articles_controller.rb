class ArticlesController < ApplicationController
  def index
  end

  def show
    @article = Article.fin(params[:id])
  end
end
