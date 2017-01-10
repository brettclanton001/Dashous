class User < ApplicationRecord

  has_many :trade_requests
  has_many :trade_request_offers, through: :trade_requests, source: :offers
  has_many :offers
  has_many :incoming_reviews, class_name: 'Review', foreign_key: 'reviewed_user_id'

  # Include default devise modules. Others available are:
  #  :lockable,
  #  :timeoutable,
  #  :validatable,
  #  :omniauthable
  devise \
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :confirmable,
    :trackable

  attr_encrypted :email, key: Settings.attr_encrypted.key

  validates \
    :username,
    uniqueness: true
  validates \
    :email,
    :encrypted_email_iv,
    :username,
    :password,
    :password_confirmation,
    presence: true
  validates_format_of :username, with: /\A[a-zA-Z0-9]+\z/
  validates_acceptance_of :terms_and_conditions
  validates_confirmation_of :password

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
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
