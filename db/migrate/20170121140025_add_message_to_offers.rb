class AddMessageToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :message, :text
  end
end
