require 'rails_helper'

RSpec.describe EvaluationTemplate, type: :model do
  
  it { is_expected.to have_db_index(:name) }

  it { is_expected.to belong_to(:user) }

  it { should define_enum_for(:state
    ) }
end
