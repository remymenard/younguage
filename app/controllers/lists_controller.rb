class ListsController < ApplicationController
  def show
    @list = List.first
  end

  def index
    @lists = List.all
  end
end
