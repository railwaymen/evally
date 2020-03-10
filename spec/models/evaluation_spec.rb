# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  it { is_expected.to belong_to(:evaluable) }

  it do
    is_expected.to(
      define_enum_for(:state)
        .with_values(
          draft: 'draft',
          completed: 'completed',
          archived: 'archived'
        )
        .backed_by_column_of_type(:string)
    )
  end

  it { is_expected.to accept_nested_attributes_for(:sections).allow_destroy(false) }
end
