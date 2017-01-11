class NotificationMailer < ActionMailer::Base

  def notify(name,email,subject,comments)
    mail(from: sender_email(email),
         to: recipients_list,
         subject: subject,
         body: prepare_body(name, email, comments))
  end

  private

  def prepare_body(name, email, comments)
    body = name.blank? ? '' : "From: #{name}\n\n"
    body += email.blank? ? '' : "Email: #{email}\n\n"
    body += "#{comments}\n"
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
    "scholar@uc.edu"
  end
end

