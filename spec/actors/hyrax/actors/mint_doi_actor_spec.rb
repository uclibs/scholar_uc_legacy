# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Hyrax::Actors::MintDoiActor do
  let(:user) { create(:user) }
  let(:curation_concern) { build :generic_work }

  subject do
    Hyrax::Actors::ActorStack.new(curation_concern,
                                  ::Ability.new(user),
                                  [described_class,
                                   Hyrax::Actors::GenericWorkActor])
  end

  let(:attributes) { {} }

  [:create, :update].each do |mode|
    context "on #{mode}" do
      it "returns true" do
        expect(subject.send(mode, attributes)).to be true
      end
    end
  end
end
