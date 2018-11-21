FactoryBot.define do
  factory :setting do
    user nil
    default_draft_items 1
    default_upcoming_items 1
    default_next_evaluation_time 1
    public_view_enabled false
  end
end
