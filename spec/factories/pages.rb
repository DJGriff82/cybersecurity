FactoryBot.define do
  factory :page do
    training_module { nil }
    title { "MyString" }
    content { "MyText" }
    order { 1 }
  end
end
