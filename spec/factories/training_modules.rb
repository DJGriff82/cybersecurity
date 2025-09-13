FactoryBot.define do
  factory :training_module do
    title { "MyString" }
    content { "MyText" }
    video_url { "MyString" }
    course_id { 1 }
    order { 1 }
  end
end
