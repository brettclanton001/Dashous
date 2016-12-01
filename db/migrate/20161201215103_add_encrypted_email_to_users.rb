class AddEncryptedEmailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :encrypted_email, :string, null: false
    add_column :users, :encrypted_email_iv, :string, null: false
    remove_column :users, :email
  end
end
