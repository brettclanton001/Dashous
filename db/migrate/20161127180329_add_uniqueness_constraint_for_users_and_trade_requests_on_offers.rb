class AddUniquenessConstraintForUsersAndTradeRequestsOnOffers < ActiveRecord::Migration[5.0]
  def change
    add_index :offers, [:user_id, :trade_request_id], unique: true
  end
end
