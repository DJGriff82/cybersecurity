FactoryBot.define do
  factory :training_module_page do
    training_module { nil }
    title { "MyString" }
    content { "MyText" }
    order { 1 }
  end
end
