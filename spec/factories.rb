FactoryGirl.define do
    factory :user do
        sequence(:name) { |n| "Person#{n}"}
        sequence(:email) { |n| "person_#{n}@example.com" }
        password "foobar22"
        password_confirmation "foobar22"
    end
    factory :post do
        content "Lorem ipsum"
        user
    end
    factory :invalid_post, parent: :post do
        content nil
    end

    factory :comment do
        body "Lorem ipstum"
        user
    end

    factory :invalid_comment, parent: :comment do
        body nil
    end

end
