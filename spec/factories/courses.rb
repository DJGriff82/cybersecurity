FactoryBot.define do
  factory :course do
    title { "MyString" }
    description { "MyText" }
    duration { 1 }
    difficulty { "MyString" }
    is_active { false }
    created_by { 1 }
  end
end
