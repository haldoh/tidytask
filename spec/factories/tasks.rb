FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    completed { false }
    user
  end
end
