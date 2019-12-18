# frozen_string_literal: true

FactoryBot.define do
  factory :setting do
    default_draft_items           { 4 }
    default_upcoming_items        { 4 }
    default_next_evaluation_time  { 6 }
    public_view_enabled           { false }

    user
  end
end
