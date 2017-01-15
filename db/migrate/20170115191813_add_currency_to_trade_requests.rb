class AddCurrencyToTradeRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :trade_requests, :currency, :string
  end
end
