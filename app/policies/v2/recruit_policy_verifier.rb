# frozen_string_literal: true

module V2
  class RecruitPolicyVerifier
    def self.authorized?(user, recruit:)
      api_client = ApiClientService.new(
        user, Rails.application.config.env.fetch(:recruitable).fetch(:host)
      )

      response = api_client.get(
        '/v2/policies/recruit',
        public_recruit_id: recruit.public_recruit_id
      )

      response.status == 204
    end
  end
end
