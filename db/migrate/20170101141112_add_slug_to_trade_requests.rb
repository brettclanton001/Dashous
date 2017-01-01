class AddSlugToTradeRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :trade_requests, :slug, :string, null: false

    add_index :trade_requests, :slug, unique: true
  end
end
