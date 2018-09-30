require 'rails_helper'

RSpec.describe Employee, type: :model do

  it { is_expected.to have_db_index(:last_name) }

  it { is_expected.to belong_to(:user) }

end
