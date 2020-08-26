class AddResponseToFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :flashcards, :response, :string
  end
end
