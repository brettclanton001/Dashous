class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :trade_request_id, null: false
      t.integer :user_id, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
