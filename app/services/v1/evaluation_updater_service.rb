module V1
  class EvaluationUpdaterService

    def initialize(attributes:, evaluation:)
      @attributes = attributes
      @evaluation = evaluation
    end

    def call
      @evaluation if update_evaluation && notify
    end

    private

    def update_evaluation
      @evaluation.attributes = evaluation_params

      unless @evaluation.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @evaluation.errors.messages)
      end

      update_next_employee_evaluation_date
      @evaluation.save!
    end

    def update_next_employee_evaluation_date
      @evaluation.employee.update!(next_evaluation_at: @attributes[:next_evaluation_at])
    end

    def evaluation_params
      @attributes.permit(:state, sections_attributes: [:id, skills: [:name, :value]])
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end
  end
end
