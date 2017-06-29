# frozen_string_literal: true
require 'rails_helper'

describe Hyrax::ContactFormController do
  routes { Hyrax::Engine.routes }
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
      allow_any_instance_of(described_class).to receive(:verify_google_recaptcha).and_return(true)
      allow_any_instance_of(Hyrax::ContactMailer).to receive(:mail).and_return(true)
      post :create, params: { contact_form: required_params }
      expect(flash[:notice]).to match("Thank you for your message!")
    end

    it 'fails on reCaptcha failure' do
      allow(described_class).to receive(:passes_captcha_or_is_logged_in?).and_return(false)
      post :create, params: { contact_form: required_params }
      expect(flash[:error]).to match("You must complete the Captcha to confirm the form.")
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
      before { post :create, params: { contact_form: required_params } }
      context "with the required parameters" do
        let(:params) { required_params }
        its(:notice) { is_expected.to eq("Thank you for your message!") }
      end
    end

    context "when encoutering a RuntimeError" do
      let(:logger) { double(info?: true) }
      before do
        allow(controller).to receive(:logger).and_return(logger)
        allow(Hyrax::ContactMailer).to receive(:contact).and_raise(RuntimeError)
      end
      it "is logged via Rails" do
        expect(logger).to receive(:error).with("Contact form failed to send: #<RuntimeError: RuntimeError>")
        post :create, params: { contact_form: required_params }
      end
    end
  end
end
