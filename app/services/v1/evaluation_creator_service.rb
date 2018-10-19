module V1
  class EvaluationCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      find_employee_and_template
      @model if create_new_evaluation && notify
    end

    private

    def create_new_evaluation
      sections_attrs = @template.sections.collect do |section|
        section.attributes.slice('name', 'group', 'width', 'position', 'skills')
      end

      @model = @employee.evaluations.build(state: :draft, completed_at: nil, sections_attributes: sections_attrs)

      unless @model.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @model.errors.messages)
      end

      @model.save!
    end

    def find_employee_and_template
      @employee ||= Employee.find_by(id: initial_params[:employee_id], user: @user)
      raise V1::ErrorResponderService.new(:record_not_found, 404, { employee: ['does not exist'] }) unless @employee

      @template ||= Template.includes(:sections).find_by(id: initial_params[:template_id], user: @user)
      raise V1::ErrorResponderService.new(:record_not_found, 404, { template: ['does not exist'] }) unless @template
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

    def initial_params
      @attributes.permit(:employee_id, :template_id)
    end
  end
end
