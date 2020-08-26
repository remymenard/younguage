class FlashcardsController < ApplicationController
  def mastered
    @flashcard = Flashcard.find(params[:id])
    if params[:flashcard][:mastered] == 'true'
      @flashcard.mastered = true
      @flashcard.save
    elsif params[:flashcard][:mastered] == 'false'
      @flashcard.mastered = false
      @flashcard.save
    end
  end
end
