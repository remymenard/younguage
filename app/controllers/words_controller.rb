class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def create
    @word = params[:word]
    @translation = params[:translation]
    Word.create!()
  end
end
