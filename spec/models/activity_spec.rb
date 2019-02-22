require 'rails_helper'

RSpec.describe Activity, type: :model do

  it { is_expected.to belong_to(:user) }

  it { is_expected.to belong_to(:activable) }

  context 'render methods' do
    let(:employee) { create(:employee) }
    let(:activity) { create(:activity, :create, activable: employee, activable_name: employee.first_name) }

    it 'expects to render correct title' do
      expect(activity.title).to eq 'New employee'
    end

    it 'expects to render correct description' do
      expect(activity.description).to eq "Welcome to new employee #{employee.first_name}!"
    end
  end
end
