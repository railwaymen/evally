module V1
  class EvaluationCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      find_employee_and_template
      @evaluation if create_new_evaluation && add_activity
    end

    private

    def create_new_evaluation
      sections_attrs = @template.sections.collect do |section|
        section.attributes.slice('name', 'group', 'width', 'position', 'skills')
      end

      @evaluation = @employee.evaluations.build(
        state: :draft,
        completed_at: nil,
        template_name: @template.name,
        sections_attributes: sections_attrs
      )

      unless @evaluation.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @evaluation.errors.full_messages)
      end

      @evaluation.save!
    end

    def find_employee_and_template
      @employee ||= Employee.find_by(id: initial_params[:employee_id], user: @user)
      raise V1::ErrorResponderService.new(:record_not_found, 404, ['Employee does not exist']) unless @employee

      @template ||= Template.includes(:sections).find_by(id: initial_params[:template_id], user: @user)
      raise V1::ErrorResponderService.new(:record_not_found, 404, ['Template does not exist']) unless @template
    end

    def add_activity
      @user.activities.create!(action: 'create', activable: @evaluation, activable_name: @employee.fullname)
    end

    def initial_params
      @attributes.permit(:employee_id, :template_id)
    end
  end
end
