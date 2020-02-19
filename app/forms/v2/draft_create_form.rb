# frozen_string_literal: true

module V2
  class DraftCreateForm
    attr_reader :draft

    def initialize(params, user:)
      @params = params
      @user = user
    end

    def save
      build_draft && validate_draft!

      ActiveRecord::Base.transaction do
        @draft.save!

        create_activity!
      end
    end

    private

    def build_draft
      @draft = employee.evaluations.build(
        state: :draft,
        template_name: resolve_template_name,
        sections_attributes: sections
      )
    end

    def validate_draft!
      return if @draft.valid?

      raise ErrorResponderService.new(:invalid_record, 422, @draft.errors.full_messages)
    end

    def employee
      @employee ||= EmployeePolicy::Scope.new(@user, Employee)
                                         .resolve.find_by(id: @params[:employee_id])

      unless @employee
        raise ErrorResponderService.new(:record_not_found, 404, ['Employee does not exist'])
      end

      @employee
    end

    def latest_evaluation
      @latest_evaluation ||= employee.latest_evaluation

      unless @latest_evaluation
        raise ErrorResponderService.new(
          :record_not_found, 404, ['Employee was not evaluated yet']
        )
      end

      @latest_evaluation
    end

    def template
      @template ||= lambda do
        return latest_evaluation if @params[:use_latest]

        Template.find_by(id: @params[:template_id])
      end.call

      unless @template
        raise ErrorResponderService.new(:record_not_found, 404, ['Template does not exist'])
      end

      @template
    end

    def resolve_template_name
      return if template.blank?

      template.is_a?(Template) ? template.name : template.template_name
    end

    def sections
      template.sections.collect do |section|
        section.attributes.slice('name', 'group', 'width', 'position', 'skills')
      end
    end

    def create_activity!
      @user.activities.create!(
        action: 'create',
        activable: @draft,
        activable_name: employee.fullname
      )
    end
  end
end
