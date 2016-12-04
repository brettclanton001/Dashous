class OfferDecorator < Draper::Decorator
  delegate_all

  def status_for_user(user)
    if object.approved? and object.reviewed_by?(user)
      'Reviewed'
    else
      object.status.capitalize
    end
  end
end
