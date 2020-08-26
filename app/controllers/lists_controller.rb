class ListsController < ApplicationController
  def show
    @list = List.new(flashcards: Flashcard.all)
    @list.save
  end
end
