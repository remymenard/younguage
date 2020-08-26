class RemoveMasteredIntoWords < ActiveRecord::Migration[6.0]
  def change
    remove_column :words, :mastered, :boolean
  end
end
