class TradeRequest < ApplicationRecord

  belongs_to :user

  validates_presence_of \
    :user_id,
    :name,
    :location,
    :kind,
    :profit

end
