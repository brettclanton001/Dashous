class AddLatitudeAndLongitudeToTradeRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :trade_requests, :latitude, :float
    add_column :trade_requests, :longitude, :float
  end
end
