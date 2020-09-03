class AddSkuToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :sku, :string
  end
end
