class FlashcardsController < ApplicationController
  def show
    @flashcard = Flashcard.first
  end

  def index
  end
end
