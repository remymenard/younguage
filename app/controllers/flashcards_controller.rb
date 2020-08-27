class FlashcardsController < ApplicationController
  def mastered
    @flashcard = Flashcard.find(params[:id])
    @flashcard.update(flashcard_params)
    # if params[:flashcard][:mastered] == 'true'
    #   @flashcard.mastered = true
    #   @flashcard.save
    # elsif params[:flashcard][:mastered] == 'false'
    #   @flashcard.mastered = false
    #   @flashcard.save
    # end
    redirect_to @flashcard.list
  end

  def index
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:mastered)
  end
end
