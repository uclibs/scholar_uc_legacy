# frozen_string_literal: true
require 'rails_helper'

describe ContactFormController do
  routes { Sufia::Engine.routes }
  let(:user) { create(:user) }
  let(:required_params) do
    {
      name: "Rose Tyler",
      email: "rose@timetraveler.org",
      subject: "The Doctor",
      message: "Run."
    }
  end

  describe 'while user is unauthenticated' do
    it 'successfully allows reCaptcha' do
      described_class.any_instance.stub(:verify_google_recaptcha).and_return(true)
      Sufia::ContactMailer.any_instance.stub(:mail).and_return(true)
      post :create, sufia_contact_form: required_params
      expect(flash[:notice]).to match(/Thank you for your message/)
    end

    it 'fails on reCaptcha failure' do
      described_class.any_instance.stub(:passes_captcha_or_is_logged_in?).and_return(false)
      post :create, sufia_contact_form: required_params
      expect(flash[:error]).to match(/You must complete the Captcha to confirm the form/)
    end
  end

  describe "while user is authenticated" do
    before { sign_in(user) }

    describe "#new" do
      subject { response }
      before { get :new }
      it { is_expected.to be_success }
    end

    describe "#create" do
      subject { flash }
      before { post :create, sufia_contact_form: params }
      context "with the required parameters" do
        let(:params) { required_params }
        its(:notice) { is_expected.to eq("Thank you for your message!") }
      end

      context "without a name" do
        let(:params)  { required_params.except(:name) }
        its([:error]) { is_expected.to eq("Sorry, this message was not sent successfully. Name can't be blank") }
      end

      context "without an email" do
        let(:params)  { required_params.except(:email) }
        its([:error]) { is_expected.to eq("Sorry, this message was not sent successfully. Email can't be blank") }
      end

      context "without a subject" do
        let(:params)  { required_params.except(:subject) }
        its([:error]) { is_expected.to eq("Sorry, this message was not sent successfully. Subject can't be blank") }
      end

      context "without a message" do
        let(:params)  { required_params.except(:message) }
        its([:error]) { is_expected.to eq("Sorry, this message was not sent successfully. Message can't be blank") }
      end

      context "with an invalid email" do
        let(:params)  { required_params.merge(email: "bad-wolf") }
        its([:error]) { is_expected.to eq("Sorry, this message was not sent successfully. Email is invalid") }
      end
    end

    context "when encoutering a RuntimeError" do
      let(:logger) { double(info?: true) }
      before do
        allow(controller).to receive(:logger).and_return(logger)
        allow(Sufia::ContactMailer).to receive(:contact).and_raise(RuntimeError)
      end
      it "is logged via Rails" do
        expect(logger).to receive(:error).with("Contact form failed to send: #<RuntimeError: RuntimeError>")
        post :create, sufia_contact_form: required_params
      end
    end
  end
end
