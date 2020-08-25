class AddTopicsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :topics, :jsonb, array: true, default: []
  end
end
