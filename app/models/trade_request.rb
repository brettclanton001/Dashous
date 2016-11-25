class TradeRequest < ApplicationRecord

  KINDS = %w(
    buy
    sell
  ).freeze

  belongs_to :user
  has_many :offers

  validates :kind, inclusion: { in: KINDS }
  validates_presence_of \
    :user_id,
    :name,
    :location,
    :kind,
    :profit

  geocoded_by :location
  after_validation :maybe_geocode

  private

  def maybe_geocode
    return true if longitude.present? and latitude.present?
    geocode
  end
end

# == Schema Information
#
# Table name: trade_requests
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  kind       :string           not null
#  profit     :string           not null
#  location   :string           not null
#  latitude   :float
#  longitude  :float
#
