class AddFieldsToTradeRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :trade_requests, :user_id, :integer, null: false
    add_column :trade_requests, :type, :string, null: false
    add_column :trade_requests, :profit, :string, null: false
    add_column :trade_requests, :location, :string, null: false
    change_column_null :trade_requests, :name, false
  end
end
