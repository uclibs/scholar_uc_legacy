class EmbargoMailer < ActionMailer::Base

  def notify(email, doc_name, days_left)
    mail(from: "scholar@uc.edu",
    to: email,
    subject: 'Embargoed Work Reminder',
    body: prepare_body(doc_name, days_left)).deliver
  end

  private

  def prepare_body(doc_name, days_left)
    if days_left == 0
      body = "This email is to notify you that your Scholar@UC item, #{doc_name},\nhas reached its embargo date and is now available to the public. \n\n"
    else
      body = "This email is to notify you that your Scholar@UC item, #{doc_name},\nhas #{days_left} days left in embargo before it is made public. \n\n"
    end
    body += "Sincerely, \n\nThe Scholar@UC Team \n \n"
    body
  end
end
