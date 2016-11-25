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
