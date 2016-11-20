class User < ApplicationRecord

  has_many :trade_requests
  has_many :trade_request_offers, through: :trade_requests, class_name: 'Offer'
  has_many :offers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
