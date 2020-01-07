# frozen_string_literal: true

module V2
  class EvaluationUpdateForm
    attr_reader :evaluation

    def initialize(evaluation, params:, user:)
      @evaluation = evaluation
      @params = params
      @user = user

      @evaluation.assign_attributes(
        state: resolve_state,
        completed_at: resolve_completed_at,
        sections_attributes: params[:sections]
      )
    end

    def save
      validate_evaluation!

      ActiveRecord::Base.transaction do
        create_activity! if @evaluation.changed?
        save_next_evaluation_date! if @evaluation.completed?

        @evaluation.save!
      end
    end

    private

    def validate_evaluation!
      return if @evaluation.valid?

      raise V1::ErrorResponderService.new(:invalid_record, 422, @evaluation.errors.full_messages)
    end

    def create_activity!
      @user.activities.create!(
        action: resolve_action,
        activable: @evaluation,
        activable_name: employee.fullname
      )
    end

    def employee
      @employee ||= @evaluation.employee
    end

    def resolve_action
      @evaluation.completed? ? :complete : :update
    end

    def resolve_completed_at
      @params[:state] == 'completed' ? Time.now.utc : nil
    end

    def resolve_state
      @params[:state] == 'completed' ? :completed : :draft
    end

    def save_next_evaluation_date!
      employee.update!(next_evaluation_at: @params[:next_evaluation_at])
    end
  end
end
