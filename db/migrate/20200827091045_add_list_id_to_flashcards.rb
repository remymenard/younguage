class AddListIdToFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_reference :flashcards, :list, foreign_key: true
  end
end
