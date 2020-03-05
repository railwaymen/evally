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

    def show
      presenter = V2::RecruitDocuments::ShowPresenter.new(recruit_document)

      render json: V2::RecruitDocuments::ShowView.render(presenter), status: :ok
    end

    private

    def recruit_document
      @recruit_document ||= RecruitDocument.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @recruit_document

      @recruit_document
    end
  end
end
