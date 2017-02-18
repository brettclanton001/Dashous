# Preview all emails at http://localhost:3000/rails/mailers/notification
class NotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification/offer_created
  def offer_created
    NotificationMailer.offer_created
  end

  # Preview this email at http://localhost:3000/rails/mailers/notification/offer_approved
  def offer_approved
    NotificationMailer.offer_approved
  end

end
