class Review < ApplicationRecord

  TONES = %w(
    positive
    negative
  ).freeze

  belongs_to :offer
  belongs_to :reviewing_user, class_name: 'User'
  belongs_to :reviewed_user, class_name: 'User'

  validates :tone, inclusion: { in: TONES }
  validates_presence_of \
    :reviewed_user_id,
    :reviewing_user_id,
    :offer_id,
    :tone

  scope :positive, -> { where(tone: 'positive') }

  def positive?
    tone == 'positive'
  end

  def negative?
    tone == 'negative'
  end
end

# == Schema Information
#
# Table name: reviews
#
#  id                :integer          not null, primary key
#  reviewed_user_id  :integer          not null
#  reviewing_user_id :integer          not null
#  tone              :string           not null
#  offer_id          :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_reviews_on_participants_and_offer  (reviewed_user_id,reviewing_user_id,offer_id) UNIQUE
#
