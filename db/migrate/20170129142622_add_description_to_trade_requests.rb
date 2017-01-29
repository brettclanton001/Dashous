class AddDescriptionToTradeRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :trade_requests, :description, :text
  end
end
