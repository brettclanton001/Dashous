class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :reviewed_user_id, null: false
      t.integer :reviewing_user_id, null: false
      t.string :tone, null: false
      t.integer :offer_id, null: false
      t.timestamps
    end
    add_index :reviews, [:reviewed_user_id, :reviewing_user_id, :offer_id], unique: true, name: :index_reviews_on_participants_and_offer
  end
end
