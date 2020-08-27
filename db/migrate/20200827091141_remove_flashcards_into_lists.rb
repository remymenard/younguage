class RemoveFlashcardsIntoLists < ActiveRecord::Migration[6.0]
  def change
    remove_column :lists, :flashcards
  end
end
