class ChangeMasteredDefaultValueInFlashcards < ActiveRecord::Migration[6.0]
  def change
    change_column :flashcards, :mastered, :boolean, default: :false
  end
end
