class SetUserCurrencyNullFalse < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :currency, false
  end
end
