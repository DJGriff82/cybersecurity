FactoryBot.define do
  factory :user_progress do
    user_id { 1 }
    training_module_id { 1 }
    status { 1 }
    score { 1 }
    time_spent { 1 }
    completed_at { "2025-09-13 19:49:07" }
  end
end
