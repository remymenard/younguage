class WordsController < ApplicationController
  def index
    @words = Word.where(user: current_user)
    @words = @words.where(translation: params[:query]) if params[:query].present?
  end

  def create
    word = params[:word]
    translation = params[:translation]
    @word = Word.create(user: current_user, word: word, translation: translation)
    # Flashcard.create!(word: @word, list: List.last)
  end
end
