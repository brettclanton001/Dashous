class User < ApplicationRecord

  has_many :trade_requests
  has_many :trade_request_offers, through: :trade_requests, source: :offers
  has_many :offers
  has_many :incoming_reviews, class_name: 'Review', foreign_key: 'reviewed_user_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_encrypted :email, key: Settings.attr_encrypted.key

  validates \
    :username,
    uniqueness: true
  validates \
    :encrypted_email,
    :encrypted_email_iv,
    :username,
    presence: true
  validates_format_of :username, with: /\A[a-zA-Z0-9]+\z/

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string           not null
#  encrypted_email        :string           not null
#  encrypted_email_iv     :string           not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
