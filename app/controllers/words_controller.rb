class WordsController < ApplicationController
  def index
    @words = Word.all

    if params[:query].present?
      @words = @words.where(translation: params[:query])
    end
  end

  def create
  end
end
