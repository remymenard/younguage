class AddFlashcardsToList < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :flashcards, :jsonb, array: true, default: []
  end
end
