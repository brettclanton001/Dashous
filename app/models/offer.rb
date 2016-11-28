class Offer < ApplicationRecord

  STATUSES = %w(
    pending
    declined
    approved
    canceled
  ).freeze

  belongs_to :trade_request
  belongs_to :user

  validates :status, inclusion: { in: STATUSES }
  validates_presence_of \
    :user_id,
    :trade_request_id,
    :status

  def pending?
    status == 'pending'
  end

  def declined?
    status == 'declined'
  end

  def approved?
    status == 'approved'
  end

  def canceled?
    status == 'canceled'
  end
end

# == Schema Information
#
# Table name: offers
#
#  id               :integer          not null, primary key
#  trade_request_id :integer          not null
#  user_id          :integer          not null
#  status           :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_offers_on_user_id_and_trade_request_id  (user_id,trade_request_id) UNIQUE
#
