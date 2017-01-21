class SetTradeRequestCurrencyNullFalse < ActiveRecord::Migration[5.0]
  def change
    change_column_null :trade_requests, :currency, false
  end
end
