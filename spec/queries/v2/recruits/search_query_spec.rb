# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Recruits::SearchQuery do
  it 'finds recruit' do
    recruit = FactoryBot.create(:recruit)
    evaluation = FactoryBot.create(
      :evaluation_completed_recruit,
      evaluable: recruit
    )

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: evaluation,
      skills: [
        { name: 'GIT', value: 2, needToImprove: false },
        { name: 'Vim', value: 1, needToImprove: true }
      ]
    )

    FactoryBot.create(
      :section,
      group: 'bool',
      sectionable: evaluation,
      skills: [
        { name: 'Be a team leader', value: true, needToImprove: false }
      ]
    )

    other_recruit = FactoryBot.create(:recruit)
    other_evaluation = FactoryBot.create(
      :evaluation_completed_recruit,
      evaluable: other_recruit
    )

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: other_evaluation,
      skills: [
        { name: 'Vim', value: 3, needToImprove: false },
        { name: 'GIT', value: 1, needToImprove: true }
      ]
    )

    FactoryBot.create(
      :section,
      group: 'bool',
      sectionable: other_evaluation,
      skills: [
        { name: 'Be a team leader', value: false, needToImprove: true }
      ]
    )

    aggregate_failures 'with GIT equals 2 stars' do
      params = {
        group: 'rating',
        name: 'GIT',
        operator: 'eq',
        value: 2
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.map(&:id)).to contain_exactly recruit.id
    end

    aggregate_failures 'with Vim greater than 2 stars' do
      params = {
        group: 'rating',
        name: 'Vim',
        operator: 'gteq',
        value: 2
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.map(&:id)).to contain_exactly other_recruit.id
    end

    aggregate_failures 'with Vim lower than 2 stars' do
      params = {
        group: 'rating',
        name: 'Vim',
        operator: 'lteq',
        value: 2
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.map(&:id)).to contain_exactly recruit.id
    end

    aggregate_failures 'who was a team leader' do
      params = {
        group: 'bool',
        name: 'Be a team leader',
        operator: 'eq',
        value: true
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.map(&:id)).to contain_exactly recruit.id
    end

    aggregate_failures 'who was not a team leader' do
      params = {
        group: 'bool',
        name: 'Be a team leader',
        operator: 'eq',
        value: false
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.map(&:id)).to contain_exactly other_recruit.id
    end
  end

  it 'finds recruit by skill from any evaluation' do
    recruit = FactoryBot.create(:recruit)

    first_evaluation = FactoryBot.create(
      :evaluation_completed_recruit,
      completed_at: 1.year.ago,
      evaluable: recruit
    )

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: first_evaluation,
      skills: [
        { name: 'GIT', value: 1, needToImprove: false },
        { name: 'Vim', value: 1, needToImprove: true }
      ]
    )

    second_evaluation = FactoryBot.create(
      :evaluation_completed_recruit,
      completed_at: 1.month.ago,
      evaluable: recruit
    )

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: second_evaluation,
      skills: [
        { name: 'Ruby', value: 2, needToImprove: false },
        { name: 'GIT', value: 2, needToImprove: true }
      ]
    )

    aggregate_failures 'evaluation 1 month old' do
      params = {
        group: 'rating',
        name: 'Ruby',
        operator: 'eq',
        value: 2
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.map(&:id)).to contain_exactly recruit.id
    end

    aggregate_failures 'evaluation 1 year old' do
      params = {
        group: 'rating',
        name: 'Vim',
        operator: 'eq',
        value: 1
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.map(&:id)).to contain_exactly recruit.id
    end

    aggregate_failures 'most recent evaluation' do
      params = {
        group: 'rating',
        name: 'GIT',
        operator: 'gteq',
        value: 1
      }

      result = described_class.new(Recruit.all, params: params).call
      expect(result.first.skill['value']).to eq 2
    end
  end

  it 'finds multiple recruits' do
    first_recruit = FactoryBot.create(:recruit)
    first_evaluation = FactoryBot.create(
      :evaluation_completed_recruit,
      completed_at: 1.year.ago,
      evaluable: first_recruit
    )

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: first_evaluation,
      skills: [
        { name: 'GIT', value: 2, needToImprove: false },
        { name: 'Vim', value: 1, needToImprove: true }
      ]
    )

    second_recruit = FactoryBot.create(:recruit)
    second_evaluation = FactoryBot.create(
      :evaluation_completed_recruit,
      completed_at: 1.month.ago,
      evaluable: second_recruit
    )

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: second_evaluation,
      skills: [
        { name: 'GIT', value: 3, needToImprove: false },
        { name: 'Python', value: 2, needToImprove: true }
      ]
    )

    params = {
      group: 'rating',
      name: 'GIT',
      operator: 'gteq',
      value: 2
    }

    result = described_class.new(Recruit.all, params: params).call
    expect(result.map(&:id)).to contain_exactly(first_recruit.id, second_recruit.id)
  end
end
