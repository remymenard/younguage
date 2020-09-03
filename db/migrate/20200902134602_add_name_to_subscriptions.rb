class AddNameToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :name, :string
  end
end
