class RemoveUserIdToFlashcards < ActiveRecord::Migration[6.0]
  def change
    remove_column :flashcards, :user_id
  end
end
