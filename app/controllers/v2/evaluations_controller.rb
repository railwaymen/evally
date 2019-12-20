# frozen_string_literal: true

module V2
  class EvaluationsController < ApplicationController
    before_action :authenticate!

    def drafts
      drafts = V2::EvaluationDraftsQuery.call

      render json: V2::EvaluationDraftSerializer.render(drafts), status: :ok
    end
  end
end
