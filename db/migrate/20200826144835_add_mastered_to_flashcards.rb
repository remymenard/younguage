class AddMasteredToFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :flashcards, :mastered, :boolean, default: :true
  end
end
