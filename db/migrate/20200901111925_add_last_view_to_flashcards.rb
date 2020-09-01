class AddLastViewToFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :flashcards, :last_view, :datetime
  end
end
