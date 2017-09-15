# frozen_string_literal: true
require 'rails_helper'
require "#{Rails.root}/lib/task_helpers/account_helper"
require 'csv'
include AccountHelper

describe AccountHelper do
  let(:proxy1) { create(:user) }
  let(:proxy2) { create(:user) }

  let(:generated_user) do
    {
      "first_name" => "Franz",
      "last_name" => "Manmen",
      "email" => "firstman@example.com",
      "proxy_emails" => "#{proxy1.email}|#{proxy2.email}"
    }
  end

  before do
    generate_uc_account(generated_user)
  end

  it "Creates a UC user" do
    expect(User.last).to eq(User.where(email: "firstman@example.com").first)
  end

  it "Assigns proxy depositors" do
    expect(User.last.can_receive_deposits_from_ids).to eq([1, 2])
  end
end
