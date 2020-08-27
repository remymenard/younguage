class AddUserIdToWords < ActiveRecord::Migration[6.0]
  def change
    add_reference :words, :user, foreign_key: true
  end
end
