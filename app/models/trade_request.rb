class TradeRequest < ApplicationRecord

  KINDS = %w(
    buy
    sell
  ).freeze

  belongs_to :user

  validates :kind, inclusion: { in: KINDS }
  validates_presence_of \
    :user_id,
    :name,
    :location,
    :kind,
    :profit

  geocoded_by :location
  after_validation :geocode

end
