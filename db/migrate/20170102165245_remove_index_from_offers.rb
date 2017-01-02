class RemoveIndexFromOffers < ActiveRecord::Migration[5.0]
  def change
    remove_index :offers, name: :index_offers_on_user_id_and_trade_request_id
  end
end
