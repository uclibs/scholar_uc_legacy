# frozen_string_literal: true
FactoryGirl.define do
  factory :document, aliases: [:private_document], class: 'Document' do
    transient do
      user { FactoryGirl.create(:user) }
    end

    title ["Test title"]
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE

    after(:build) do |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)
    end

    factory :public_document do
      visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
    end

    factory :registered_document do
      read_groups ["registered"]
    end

    factory :document_with_one_file do
      before(:create) do |work, evaluator|
        work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user, title: ['A Contained FileSet'], label: 'filename.pdf')
      end
    end
  end
end
