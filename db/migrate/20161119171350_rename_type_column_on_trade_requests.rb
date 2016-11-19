class RenameTypeColumnOnTradeRequests < ActiveRecord::Migration[5.0]
  def change
    rename_column :trade_requests, :type, :kind
  end
end
