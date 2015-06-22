class ContactRequestsController < ApplicationController
  SUCCESS_NOTICE = "Thank you.  Your message has been sent to the Scholar@UC team."
  FAIL_NOTICE = "You must complete the Captcha to confirm the form."

  def new
  end

  def verify_google_recptcha(key,response)
    status = `curl "https://www.google.com/recaptcha/api/siteverify?secret=#{CAPTCHA_SERVER['secret_key']}&response=#{response}"`
    hash = JSON.parse(status)
    hash["success"] == true ? true : false
  end

  def create
    name = params[:name]
    email = params[:email]
    comments = params[:comments]
    status = verify_google_recptcha(CAPTCHA_SERVER['secret_key'],params["g-recaptcha-response"])

    if (status)
      NotificationMailer.notify(name,email,comments).deliver
      redirect_to catalog_index_path, notice: SUCCESS_NOTICE
    else
      redirect_to contact_requests_path, notice: FAIL_NOTICE
    end
  end
end
