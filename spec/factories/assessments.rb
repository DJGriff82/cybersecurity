FactoryBot.define do
  factory :assessment do
    title { "MyString" }
    questions { "" }
    passing_score { 1 }
    time_limit { 1 }
    course_id { 1 }
  end
end
