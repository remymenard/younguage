class FlashcardsController < ApplicationController
  def mastered
    @flashcard = Flashcard.find(params[:id])
    @flashcard.update(flashcard_params)
    @flashcard.update(last_view: Time.now)

    redirect_to @flashcard.list
  end

  def index
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:mastered)
  end
end
