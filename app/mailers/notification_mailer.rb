class NotificationMailer < ActionMailer::Base

  def notify(name,email,comments)
    mail(from: sender_email(email),
         to: recipients_list,
         subject: "#{t('sufia.product_name')}: Contact Form Submission",
         body: prepare_body(name, email, comments))
  end

  private

  def prepare_body(name, email, comments)
    body = "From: #{name}\n\n"
    body += "Email: #{email}\n\n"
    body += "Message: #{comments}\n"
    body
  end

  def recipients_list
    return @list if !@list.blank?
    @list = YAML.load(File.open(File.join(Rails.root, "config/recipients_list.yml"))).split(" ")
    return @list
  end

  def sender_email(email)
    email.blank? ? default_sender : email
  end

  def default_sender
    @sender ||= YAML.load(File.open(File.join(Rails.root, "config/smtp_config.yml")))
    return @sender[Rails.env]["smtp_user_name"]
  end
end

