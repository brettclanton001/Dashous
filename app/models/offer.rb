class Offer < ApplicationRecord

  STATUSES = %w(
    pending
    rejected
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

end
