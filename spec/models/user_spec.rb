require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_secure_password }

  it { is_expected.to have_db_index(:email) }

end
