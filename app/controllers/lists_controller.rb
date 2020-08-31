class ListsController < ApplicationController
  def show
    @list = List.last
    @percentage = (@list.flashcards.where(mastered: true).count.to_f / @list.flashcards.count.to_f * 100).round
  end

  def index
    @lists = List.all
  end
end
