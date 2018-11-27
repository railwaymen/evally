module V1
  class EvaluationUpdaterService

    def initialize(attributes:, evaluation:)
      @attributes = attributes
      @evaluation = evaluation
    end

    def call
      @evaluation if update_evaluation && add_activity
    end

    private

    def update_evaluation
      @evaluation.attributes = evaluation_params

      unless @evaluation.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @evaluation.errors.full_messages)
      end

      if @evaluation.completed?
        Evaluation.where(employee_id: @evaluation.employee_id, state: :completed).update_all(state: :archived)
        @evaluation.employee.update!(next_evaluation_at: @attributes[:next_evaluation_at])
      end

      @evaluation.save!
    end

    def evaluation_params
      @attributes.permit(:state, :completed_at, :updated_at, sections_attributes: [:id, skills: [:name, :value, :needToImprove]])
    end

    def add_activity
      @employee = @evaluation.employee

      action = @evaluation.completed? ? 'complete' : 'update'
      @employee.user.activities.create!(action: action, activable: @evaluation, activable_name: @employee.fullname)
    end
  end
end
