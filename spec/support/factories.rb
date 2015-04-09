FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user-#{n}@intrepid.io" }
  end

  factory :hire_type do
    contract_type 'full_time'
    sequence(:name){ |n| "hire_type #{n}"}
    work_status 'no_visa'

    trait :full_time do
      contract_type 'full_time'
      sequence(:name){ |n| "Full Time #{n}"}
    end

    trait :apprentice do
      contract_type 'apprentice'
      sequence(:name){ |n| "Apprentice #{n}"}
    end

    trait :international_full_time do
      work_status 'visa'
      sequence(:name){ |n| "International Full Time #{n}"}
    end

    trait :international_apprentice do
      contract_type 'apprentice'
      sequence(:name){ |n| "International Apprentice #{n}"}
      work_status 'visa'
    end
  end

  factory :profile do
    bio 'my bio'
    communication_style "Communicative"
    sequence(:first_name) { |n| "Jo-#{n}" }
    sequence(:last_name) { |n| "Intrepid-#{n}" }
    hire_type
    photo nil
    sequence(:slack_handle) { |n| "intrepid#{n}" }
    title 'Developer'
    user
    team

    trait :apprentice_profile do
      association :hire_type, factory: [:hire_type, :apprentice]
    end

    trait :has_photo do
      photo File.new(File.expand_path("spec/fixtures/assets/images/old_missing.png"))
    end

    trait :international_full_time_profile do
      association :hire_type, factory: [:hire_type, :international_full_time]
    end
  end

  factory :team do
    name 'unassigned'

    trait :android do
      name 'Android'
    end

    trait :backend do
      name 'Backend'
    end

    trait :design do
      name 'Design'
    end

    trait :ios do
      name 'iOS'
    end

    trait :management do
      name 'Management'
    end

    trait :pm do
      name 'Project Management'
    end
  end
end
