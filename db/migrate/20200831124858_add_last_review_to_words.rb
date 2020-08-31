class AddLastReviewToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :last_review, :datetime
  end
end
