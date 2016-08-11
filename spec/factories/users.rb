FactoryGirl.define do
  factory :shibboleth_person, class: Person do
    depositor 'fake.user@uc.edu'
    email 'fake.user@uc.edu'
  end

  factory :shibboleth_profile, class: Profile do
    depositor 'fake.user@uc.edu'
  end

  factory :shibboleth_user, class: 'User' do
    ignore do
      count 1
      person_pid nil
    end
    email 'fake.user@uc.edu'
    first_name 'Fake'
    last_name 'User'
    password '12345678'
    password_confirmation '12345678'
    sign_in_count {"#{count}"}
    repository_id {"#{person_pid}"}
  end
end
