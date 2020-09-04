class WordsController < ApplicationController
  def index
    @words = Word.where(user: current_user)
    @words = @words.where(translation: params[:query]) if params[:query].present?
  end

  def create
    word = params[:word].downcase
    translation = params[:translation].downcase
    user = current_user

    premium_restriction = user.orders.where(state: 'paid').empty? && user.words.length >= 5
    @word = Word.create(user: user, word: word, translation: translation) unless premium_restriction

    return "" if premium_restriction

    # Flashcard.create!(word: @word, list: List.last)
  end
end
