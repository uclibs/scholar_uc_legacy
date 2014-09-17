class ContactRequestsController < ApplicationController
  SUCCESS_NOTICE = "Thank you.  Your message has been sent to the Scholar@UC team."

  def new
  end

  def create
    name = params[:name]
    email = params[:email]
    comments = params[:comments]
    NotificationMailer.notify(name,email,comments).deliver
    redirect_to catalog_index_path, notice: SUCCESS_NOTICE
  end

end
