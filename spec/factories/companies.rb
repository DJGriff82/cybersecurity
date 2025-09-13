FactoryBot.define do
  factory :company do
    name { "MyString" }
    subdomain { "MyString" }
    contact_email { "MyString" }
    subscription_status { "MyString" }
    max_users { 1 }
  end
end
