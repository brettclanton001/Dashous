class Offer < ApplicationRecord

  STATUSES = %w(
    pending
    declined
    approved
    canceled
  ).freeze

  belongs_to :trade_request
  belongs_to :user
  has_many :reviews

  validates :status, inclusion: { in: STATUSES }
  validates_presence_of \
    :user_id,
    :trade_request_id,
    :status
  validate :offer_users
  validate :previous_offers, on: :create

  scope :approved, -> { where(status: 'approved') }

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

  def reviewed_by?(user)
    reviews.where(reviewing_user: user).exists?
  end

  private

  def offer_users
    if self.user == self.trade_request.user
      errors.add(:user, 'You cannot make an offer with yourself.')
    end
  end

  def previous_offers
    if self.user.offers.where(trade_request_id: self.trade_request_id, status: [:pending, :declined]).exists?
      errors.add(:user, 'You cannot make an offer on this trade request at this time.')
    end
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
