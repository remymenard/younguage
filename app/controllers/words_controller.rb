class WordsController < ApplicationController
  def index
    @words = Word.all

    if params[:query].present?
      @words = @words.where(translation: params[:query])
    end
  end

  def create
    @word = params[:word]
    @translation = params[:translation]
    Word.create!(user: current_user, word: @word, translation: @translation)
  end
end
