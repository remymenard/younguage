class ListsController < ApplicationController
  def show
    @list = List.last
  end

  def index
    @lists = List.all
  end
end
