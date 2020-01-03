# frozen_string_literal: true

module V2
  class EvaluationUpdateForm
    attr_reader :evaluation

    delegate :employee, to: :evaluation

    def initialize(evaluation, params:, user:)
      @evaluation = evaluation
      @user = user

      @evaluation.sections_attributes = params[:sections]
    end

    def call
      self if save_evaluation
    end

    private

    def save_evaluation
      unless @evaluation.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @evaluation.errors.full_messages)
      end

      ActiveRecord::Base.transaction do
        create_activity!
        @evaluation.save!
      end
    end

    def create_activity!
      @user.activities.create!(
        action: :update,
        activable: @evaluation,
        activable_name: @evaluation.employee.fullname
      )
    end
  end
end
