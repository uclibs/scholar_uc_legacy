FactoryGirl.define do
  factory :article do
    abstract "This is my abstract. It has a lot of words"
    alternate_title "Where is my cheese"
    bibliographic_citation "Who moved my cheese. Foo Bar. 2014"
    contributor "Fez Baz"
    coverage_spatial "Cincinnati"
    coverage_temporal "2014"
    creator "Foo Bar"
    date_created {Date.today.to_s("%Y-%m-%d")}
    date_modified {Date.today.to_s("%Y-%m-%d")}
    date_uploaded {Date.today.to_s("%Y-%m-%d")}
    identifier "123456:abcdef"
    issn "1234-5678"
    journal_title "Study of studies"
    language "English"
    note "This work was made possible with funding from your favorite cheesemonger"
    publisher "Cheese, Inc."
    requires "PDF reader"
    rights "All rights reserved"
    subject "Cookery -- Cheese"
    title "Who moved my Cheese?"
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  end

  factory :dataset do
    alternate_title "Cheese stats"
    bibliographic_citation "Who moved my cheese. Foo Bar. 2014"
    contributor "Fez Baz"
    coverage_spatial "Cincinnati"
    coverage_temporal "2014"
    creator "Foo Bar"
    date_created {Date.today.to_s("%Y-%m-%d")}
    date_modified {Date.today.to_s("%Y-%m-%d")}
    date_uploaded {Date.today.to_s("%Y-%m-%d")}
    description "A lot of data about everyone's favorite cheeses"
    identifier "123456:abcdef"
    language "English"
    note "This work was made possible with funding from your favorite cheesemonger"
    publisher "Cheese, Inc."
    requires "generic text editor"
    rights "All rights reserved"
    subject "Cookery -- Cheese"
    source "These come from somewhere else"
    title "Cheese statistics"
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  end

  factory :document do
    alternate_title "Cheese inquiry"
    bibliographic_citation "Questions about cheese. Foo Bar. 2014"
    contributor "Fez Baz"
    coverage_spatial "Cincinnati"
    coverage_temporal "2014"
    creator "Foo Bar"
    date_created {Date.today.to_s("%Y-%m-%d")}
    date_modified {Date.today.to_s("%Y-%m-%d")}
    date_uploaded {Date.today.to_s("%Y-%m-%d")}
    description "Questions for an expert, about cheese"
    identifier "123456:abcdef"
    language "English"
    note "This work was made possible with funding from your favorite cheesemonger"
    publisher "Cheese, Inc."
    requires "generic text editor"
    rights "All rights reserved"
    subject "Cookery -- Cheese"
    source "These come from somewhere else"
    title "Questions about cheese"
    genre "Letter"
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  end

  factory :generic_work do
    alternate_title "Queso Primo"
    bibliographic_citation "Cheese. Foo Bar. 2014"
    contributor "Fez Baz"
    coverage_spatial "Cincinnati"
    coverage_temporal "2014"
    creator "Foo Bar"
    date_created {Date.today.to_s("%Y-%m-%d")}
    date_modified {Date.today.to_s("%Y-%m-%d")}
    date_uploaded {Date.today.to_s("%Y-%m-%d")}
    description "An intro to cheese"
    identifier "123456:abcdef"
    language "English"
    note "This work was made possible with funding from your favorite cheesemonger"
    publisher "Cheese, Inc."
    requires "PDF reader"
    rights "All rights reserved"
    subject "Cookery -- Cheese"
    title "Cheese. A Primer"
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  end

  factory :image do
    alternate_title "Cheese #42"
    bibliographic_citation "Study in Cheese. Foo Bar. 2014"
    contributor "Fez Baz"
    coverage_spatial "Cincinnati"
    coverage_temporal "2014"
    creator "Foo Bar"
    cultural_context "French"
    date_created {Date.today.to_s("%Y-%m-%d")}
    date_modified {Date.today.to_s("%Y-%m-%d")}
    date_photographed {Date.today.to_s("%Y-%m-%d")}
    date_uploaded {Date.today.to_s("%Y-%m-%d")}
    description "A lot of data about everyone's favorite cheeses"
    genre "Photograph"
    identifier "123456:abcdef"
    inscription "Dedicated to cheese lovers"
    location "France"
    material "Paper"
    measurements "42\"x98\""
    note "This work was made possible with funding from your favorite cheesemonger"
    publisher "Cheese, Inc."
    requires "generic text editor"
    rights "All rights reserved"
    subject "Cookery -- Cheese"
    source "These come from somewhere else"
    title "Study in Cheese"
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  end
  factory :video, class: Video do
    ignore do
      user { FactoryGirl.create(:user) }
    end

    sequence(:title) {|n| "Title #{n}"}
    rights { Sufia.config.cc_licenses.keys.first.dup }
    date_uploaded { Date.today }
    date_modified { Date.today }
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_AUTHENTICATED

    before(:create) { |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)
      work.contributor << "Some Body"
      work.creator << "Me"
    }

    factory :private_video do
      visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
    end
    factory :public_video do
      visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
    end

    factory :video_with_files do
      ignore do
        file_count 3
      end

      after(:create) do |work, evaluator|
        FactoryGirl.create_list(:generic_file, evaluator.file_count, batch: work, user: evaluator.user)
      end
    end
  end
end
