FactoryBot.define do
  factory :module_page do
    training_module { nil }
    title { "MyString" }
    content { "MyText" }
    order { 1 }
  end
end
