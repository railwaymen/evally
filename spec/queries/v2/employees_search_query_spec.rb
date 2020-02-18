# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeesSearchQuery do
  it 'finds employee' do
    employee = FactoryBot.create(:employee)
    evaluation = FactoryBot.create(:evaluation, :completed, employee: employee)

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: evaluation,
      skills: [
        { name: 'GIT', value: 3, needToImprove: false },
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

    other_employee = FactoryBot.create(:employee)
    other_evaluation = FactoryBot.create(:evaluation, :completed, employee: other_employee)

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

    aggregate_failures 'with GIT equals 3 stars' do
      params = {
        group: 'rating',
        name: 'GIT',
        operator: 'eq',
        value: 3
      }

      result = described_class.call(params)
      expect(result.map(&:id)).to contain_exactly employee.id
    end

    aggregate_failures 'with Vim greater than 2 stars' do
      params = {
        group: 'rating',
        name: 'Vim',
        operator: 'gteq',
        value: 2
      }

      result = described_class.call(params)
      expect(result.map(&:id)).to contain_exactly other_employee.id
    end

    aggregate_failures 'with Vim greater than 2 stars' do
      params = {
        group: 'rating',
        name: 'Vim',
        operator: 'lteq',
        value: 2
      }

      result = described_class.call(params)
      expect(result.map(&:id)).to contain_exactly employee.id
    end

    aggregate_failures 'who was a team leader' do
      params = {
        group: 'bool',
        name: 'Be a team leader',
        operator: 'eq',
        value: true
      }

      result = described_class.call(params)
      expect(result.map(&:id)).to contain_exactly employee.id
    end

    aggregate_failures 'who was not a team leader' do
      params = {
        group: 'bool',
        name: 'Be a team leader',
        operator: 'eq',
        value: false
      }

      result = described_class.call(params)
      expect(result.map(&:id)).to contain_exactly other_employee.id
    end
  end

  it 'finds employee base on latest evaluation' do
    employee = FactoryBot.create(:employee)
    first_evaluation = FactoryBot.create(:evaluation, :completed, employee: employee)

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: first_evaluation,
      skills: [
        { name: 'Vim', value: 2, needToImprove: true }
      ]
    )

    second_evaluation = FactoryBot.create(:evaluation, :completed, employee: employee)

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: second_evaluation,
      skills: [
        { name: 'Vim', value: 3, needToImprove: true }
      ]
    )

    params = {
      group: 'rating',
      name: 'Vim',
      operator: 'eq',
      value: 3
    }

    result = described_class.call(params)
    expect(result.map(&:id)).to contain_exactly employee.id
  end

  it 'uses equal sign when invalid operator' do
    employee = FactoryBot.create(:employee)
    evaluation = FactoryBot.create(:evaluation, :completed, employee: employee)

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: evaluation,
      skills: [
        { name: 'Vim', value: 2, needToImprove: true }
      ]
    )

    other_employee = FactoryBot.create(:employee)
    other_evaluation = FactoryBot.create(:evaluation, :completed, employee: other_employee)

    FactoryBot.create(
      :section,
      group: 'rating',
      sectionable: other_evaluation,
      skills: [
        { name: 'Vim', value: 3, needToImprove: false }
      ]
    )

    params = {
      group: 'rating',
      name: 'Vim',
      operator: 'unknown',
      value: 2
    }

    result = described_class.call(params)
    expect(result.map(&:id)).to contain_exactly employee.id
  end
end
