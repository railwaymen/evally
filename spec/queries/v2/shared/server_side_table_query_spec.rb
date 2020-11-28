# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Shared::ServerSideTableQuery do
  describe '.call' do
    it 'expects to return full scope if no params' do
      record_one, record_two, record_three = FactoryBot.create_list(:employee, 3)

      query = described_class.new(Employee.all, params: {})

      expect(query.call).to contain_exactly record_one, record_two, record_three
    end

    it 'expects to return 1 page with 2 records' do
      record_one, record_two = FactoryBot.create_list(:employee, 2)
      FactoryBot.create(:employee)

      params = {
        page: 1,
        per_page: 2
      }

      query = described_class.new(Employee.all, params: params)

      expect(query.call).to contain_exactly record_one, record_two
    end

    it 'expects to return records filtering by position' do
      record_one = FactoryBot.create(
        :employee,
        position: 'RoR Developer'
      )

      FactoryBot.create(
        :employee,
        position: 'QA Engineer'
      )

      record_two = FactoryBot.create(
        :employee,
        position: 'RoR Developer'
      )

      params = {
        filters: {
          position: 'RoR Developer'
        }
      }

      query = described_class.new(Employee.all, params: params)

      expect(query.call).to contain_exactly record_one, record_two
    end

    it 'expects to return records filtering by multiple' do
      record_one = FactoryBot.create(
        :employee,
        position: 'RoR Developer',
        group: 'Developers'
      )

      FactoryBot.create(
        :employee,
        position: 'QA Engineer',
        group: 'QAs'
      )

      FactoryBot.create(
        :employee,
        position: 'RoR Developer',
        group: 'Team Leads'
      )

      params = {
        filters: {
          position: 'RoR Developer',
          group: 'Developers'
        }
      }

      query = described_class.new(Employee.all, params: params)

      expect(query.call).to contain_exactly record_one
    end

    it 'expects to return records ignoring unknown filter' do
      record_one = FactoryBot.create(
        :employee,
        position: 'RoR Developer'
      )

      FactoryBot.create(
        :employee,
        position: 'QA Engineer'
      )

      record_two = FactoryBot.create(
        :employee,
        position: 'RoR Developer'
      )

      params = {
        filters: {
          position: 'RoR Developer',
          unknown_column: 'random value'
        }
      }

      query = described_class.new(Employee.all, params: params)

      expect(query.call).to contain_exactly record_one, record_two
    end

    it 'expects to return records sorting asc by position' do
      record_one = FactoryBot.create(
        :employee,
        position: 'A'
      )

      FactoryBot.create(
        :employee,
        position: 'C'
      )

      record_two = FactoryBot.create(
        :employee,
        position: 'B'
      )

      params = {
        page: 1,
        per_page: 2,
        sort_by: 'position',
        sort_dir: 'asc'
      }

      query = described_class.new(Employee.all, params: params)

      expect(query.call).to contain_exactly record_one, record_two
    end

    it 'expects to return records sorting desc by position' do
      record_one = FactoryBot.create(
        :employee,
        position: 'C'
      )

      FactoryBot.create(
        :employee,
        position: 'A'
      )

      record_two = FactoryBot.create(
        :employee,
        position: 'B'
      )

      params = {
        page: 1,
        per_page: 2,
        sort_by: 'position',
        sort_dir: 'desc'
      }

      query = described_class.new(Employee.all, params: params)

      expect(query.call).to contain_exactly record_one, record_two
    end

    it 'expects to return records using search' do
      record_one = FactoryBot.create(
        :employee,
        position: 'Junior Android Dev'
      )

      FactoryBot.create(
        :employee,
        position: 'Marketing Specialist'
      )

      record_two = FactoryBot.create(
        :employee,
        position: 'Senior Android Dev'
      )

      params = {
        search: 'android'
      }

      query = described_class.new(Employee.all, params: params)

      expect(query.call).to contain_exactly record_one, record_two
    end

    it 'expect to return records without signature' do
      record_one = FactoryBot.create(
        :employee,
        signature: nil
      )

      FactoryBot.create(
        :employee,
        signature: 'E/B2B/001'
      )

      record_two = FactoryBot.create(
        :employee,
        signature: nil
      )

      params = {
        filters: {
          signature: nil
        }
      }

      query = described_class.new(Employee.all, params: params, require_values: false)

      expect(query.call).to contain_exactly record_one, record_two
    end

    it 'expects to work with strong action controller parameters' do
      record_one = FactoryBot.create(
        :employee,
        position: 'Junior Android Dev',
        group: 'Android',
        hired_on: '2020-01-01'
      )

      FactoryBot.create(
        :employee,
        position: 'Junior Marketing Specialist',
        group: 'Marketing',
        hired_on: '2020-02-01'
      )

      FactoryBot.create(
        :employee,
        position: 'Senior Android Dev',
        group: 'Android',
        hired_on: '2019-01-01'
      )

      FactoryBot.create(
        :employee,
        position: 'Senior Android Dev',
        group: 'Android',
        hired_on: '2018-01-01'
      )

      params = ActionController::Parameters.new(
        page: 1,
        per_page: 2,
        search: 'junior',
        sort_by: 'hired_on',
        sort_dir: 'desc',
        filters: { group: 'Android' }
      )

      query = described_class.new(Employee.all, params: params.permit!)

      expect(query.call).to contain_exactly record_one
    end
  end
end
