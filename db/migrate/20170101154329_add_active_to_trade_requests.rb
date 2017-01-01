class AddActiveToTradeRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :trade_requests, :active, :boolean, null: false, default: false
  end
end
