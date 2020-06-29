# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitsController, type: :controller do
  let(:admin) { FactoryBot.create(:user, role: :admin) }

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :show, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with recruit data' do
        recruit = FactoryBot.create(:recruit)

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)
        FactoryBot.create(:section, sectionable: evaluation)

        sign_in admin
        get :show, params: { id: recruit.public_recruit_id }

        expect(response).to have_http_status 200
        expect(json_response.keys).to contain_exactly(
          'evaluations', 'evaluation', 'evaluators', 'sections', 'templates', 'comments'
        )
      end
    end
  end

  describe '#skills' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :skills
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with skills list' do
        evaluation = FactoryBot.create(:evaluation_completed_recruit)

        FactoryBot.create(
          :section,
          group: 'rating',
          sectionable: evaluation,
          skills: [
            { name: 'Vim', value: 1, needToImprove: false }
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

        sign_in admin
        get :skills

        expect(response).to have_http_status 200
        expect(json_response).to include(
          { 'group' => 'bool', 'name' => 'Be a team leader' },
          'group' => 'rating', 'name' => 'Vim'
        )
      end
    end
  end

  describe '#search' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :search
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with searched recruit' do
        recruit1, recruit2 = FactoryBot.create_list(:recruit, 2)

        evaluation1 = FactoryBot.create(
          :evaluation_completed_recruit,
          evaluable: recruit1
        )

        FactoryBot.create(
          :section,
          group: 'rating',
          sectionable: evaluation1,
          skills: [
            { name: 'Vim', value: 1, needToImprove: false }
          ]
        )

        FactoryBot.create(
          :section,
          group: 'bool',
          sectionable: evaluation1,
          skills: [
            { name: 'Be a team leader', value: true, needToImprove: false }
          ]
        )

        evaluation2 = FactoryBot.create(
          :evaluation_completed_recruit,
          evaluable: recruit2
        )

        FactoryBot.create(
          :section,
          group: 'rating',
          sectionable: evaluation2,
          skills: [
            { name: 'Vim', value: 2, needToImprove: false }
          ]
        )

        params = {
          group: 'rating',
          name: 'Vim',
          operator: 'eq',
          value: 1
        }

        sign_in admin
        get :search, params: params

        expect(response).to have_http_status 200
        expect(json_response.map { |r| r['id'] }).to include recruit1.id
      end

      it 'responds with empty array' do
        params = {
          group: 'rating',
          name: 'Vim',
          operator: 'eq',
          value: 1
        }

        sign_in admin
        get :search, params: params

        expect(response).to have_http_status 200
        expect(json_response).to eq []
      end
    end
  end

  describe '#webhook' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        post :webhook, params: { recruit: { public_recruit_id: 1 } }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'creates new recruit' do
        recruit_attribtues = FactoryBot.attributes_for(:recruit, evaluator: nil)

        params = {
          recruit: {
            public_recruit_id: recruit_attribtues[:public_recruit_id]
          }
        }

        sign_in admin

        expect do
          post :webhook, params: params
        end.to(change { Recruit.count }.by(1))

        expect(response).to have_http_status 204
      end

      it 'confirms that recruit exists' do
        recruit = FactoryBot.create(:recruit, evaluator: nil)

        params = {
          recruit: {
            public_recruit_id: recruit.public_recruit_id
          }
        }

        sign_in admin

        expect do
          post :webhook, params: params
        end.not_to(change { Recruit.count })

        expect(response).to have_http_status 204
      end

      it 'creates proper notificaions' do
        evaluator = FactoryBot.create(:user, role: :evaluator)
        recruiter = FactoryBot.create(:user, role: :recruiter)

        params = {
          recruit: FactoryBot.attributes_for(:recruit, evaluator_token: evaluator.email_token)
        }

        sign_in admin

        expect do
          post :webhook, params: params
        end.to(change { Notification.count }.by(2))

        latest_recruit = Recruit.last

        expect(evaluator.notifications.last).to have_attributes(
          action: 'assign_me',
          actor_id: admin.id,
          read_at: nil,
          notifiable: latest_recruit
        )

        expect(recruiter.notifications.last).to have_attributes(
          action: 'assign_evaluator',
          actor_id: admin.id,
          read_at: nil,
          notifiable: latest_recruit
        )
      end

      it 'responds with error if public recruit id blank' do
        params = {
          recruit: {
            public_recruit_id: nil
          }
        }

        sign_in admin
        post :webhook, params: params

        expect(response).to have_http_status 422
      end
    end
  end
end
