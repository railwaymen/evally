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

    def new
      presenter = V2::RecruitDocuments::NewPresenter.new

      render json: V2::RecruitDocuments::NewView.render(presenter), status: :ok
    end

    def create
      create_form.save

      render(
        json: V2::RecruitDocuments::Serializer.render(create_form.recruit_document),
        status: :created
      )
    end

    def update
      update_form.save

      render(
        json: V2::RecruitDocuments::Serializer.render(update_form.recruit_document),
        status: :ok
      )
    end

    private

    def recruit_document
      @recruit_document ||= RecruitDocument.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @recruit_document

      @recruit_document
    end

    def create_form
      @create_form ||= V2::RecruitDocuments::BasicForm.new(
        RecruitDocument.new,
        params: recruit_document_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::RecruitDocuments::BasicForm.new(
        recruit_document,
        params: recruit_document_params,
        user: current_user
      )
    end

    def recruit_document_params
      params.require(:recruit_document).permit(
        :first_name, :last_name, :gender, :email, :phone, :position, :group, :received_at, :source,
        :status
      )
    end
  end
end
