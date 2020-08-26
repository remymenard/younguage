class FlashcardsController < ApplicationController
  def show
    @flashcard = Flashcard.first
  end
end
