class ContactMailer < ApplicationMailer
  def contact_mail(picture)
    @picture = picture
    mail to: @picture.user.email, subject: "確認メール"
  end
end
