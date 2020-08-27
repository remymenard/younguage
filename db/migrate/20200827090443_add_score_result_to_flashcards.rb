class AddScoreResultToFlashcards < ActiveRecord::Migration[6.0]
  def change
    add_column :flashcards, :score_result, :integer
  end
end
