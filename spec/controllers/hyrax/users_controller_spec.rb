# frozen_string_literal: true
require 'rails_helper'

describe Hyrax::UsersController, type: :controller do
  describe "#search" do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      user.first_name = 'Lucy'
      user.last_name = 'Bearcat'
      user.save!
    end

    it 'finds a user by email' do
      term = user.email.split('@').first
      expect(controller.search(term).first.email).to eq(user.email)
    end

    it 'finds a user by first name' do
      expect(controller.search('Lucy').first.email).to eq(user.email)
    end

    it 'finds a user by last name' do
      expect(controller.search('Bearcat').first.email).to eq(user.email)
    end

    it 'returns no users where there are no matches' do
      expect(controller.search('notfound').first).to eq(nil)
    end
  end
end
