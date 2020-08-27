class ListsController < ApplicationController
  def show
    @list = List.first
  end

  # trouver la flashcard suivante
  def next
    @flashcard = Flashcard.find(flashcard_id)
    @list = List.find(list_id)
    current_position = @list.flashcards.index(@flashcards)
    if current_position == @list.flashcards.length - 1
      @list.update(list_id) # si la flashcard actuelle est la derniere, updater la liste
    else
      @next_flashcard = @list.flashcards[current_position + 1]
      current_position += 1
      response = { data: [
        {
          flashcard_id: current_position,
          list_id: list_id
        }
      ] }
      response_json = JSON.generate(response)
      render json: response_json
    end
  end

  private

  # mettre a jour la liste en gardant que les flashcards non mastered
  def update(list_id)
    @list = List.find(list_id)
    @list.flashcards = @list.flashcards.where(mastered: false)
    @list.save

    if !@list.flashcards.empty?
      @next_flashcard = @list.flashcards.first
    else
      redirect_to '#' # si la liste est vide rediriger vers la page finale
    end
  end
end
