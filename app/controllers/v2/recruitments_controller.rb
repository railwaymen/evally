# frozen_string_literal: true

module V2
  class RecruitmentsController < ApplicationController
    before_action :authenticate_user!

    def show
      presenter = V2::Recruitments::ShowPresenter.new(recruitment)

      render json: V2::Recruitments::ShowView.render(presenter), status: :ok
    end

    def create
      create_form.save

      render json: V2::Recruitments::Serializer.render(create_form.recruitment), status: :created
    end

    def update
      update_form.save

      render json: V2::Recruitments::Serializer.render(update_form.recruitment), status: :ok
    end

    private

    def recruitments_scope
      Recruitment.all
    end

    def recruitment
      @recruitment ||=
        V2::Recruitments::BasicQuery.call(recruitments_scope).find_by(id: params[:id])

      raise ErrorResponderService.new(:record_not_found, 404) unless @recruitment

      @recruitment
    end

    def create_form
      @create_form ||= V2::Recruitments::CreateForm.new(
        params: recruitment_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::Recruitments::UpdateForm.new(
        recruitment,
        params: recruitment_params,
        user: current_user
      )
    end

    def recruitment_params
      {
        candidate: params.require(:recruitment).permit(
          :first_name, :last_name, :email, :gender, :evaluator_id
        ),
        recruitment: params.require(:recruitment).permit(
          :phone, :status, :position, :group, :received_at, :social_links, :source
        )
      }
    end
  end
end
