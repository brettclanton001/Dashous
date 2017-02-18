class NotificationJob < ApplicationJob
  queue_as :notification

  def perform(action, record_id)
    NotificationMailer.public_send(action, record_id).deliver_now
  end
end
