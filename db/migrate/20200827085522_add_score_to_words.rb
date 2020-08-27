class AddScoreToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :score, :integer
  end
end
