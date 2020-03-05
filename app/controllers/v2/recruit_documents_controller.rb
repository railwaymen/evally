# frozen_string_literal: true

module V2
  class RecruitDocumentsController < ApplicationController
    before_action :authenticate_user!

    def index
      presenter = V2::RecruitDocuments::IndexPresenter.new(
        scope: RecruitDocument.by_group(params.dig(:group)).by_status(params.dig(:status))
      )

      render json: V2::RecruitDocuments::IndexView.render(presenter), status: :ok
    end
  end
end
