# frozen_string_literal: true

module V2
  class DraftCreateForm
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

    def draft
      V2::EvaluationsQuery.call(Evaluation.draft).find_by(id: @draft.id)
    end

    private

    def build_draft
      @draft ||= begin
        return latest_evaluation.dup if @params[:use_latest]

        employee.evaluations.build(template_name: template.name, sections_attributes: sections)
      end

      @draft.assign_attributes(state: :draft, completed_at: nil)
    end

    def validate_draft!
      return if @draft.valid?

      raise V1::ErrorResponderService.new(:invalid_record, 422, @draft.errors.full_messages)
    end

    def employee
      @employee ||= Employee.find_by(id: @params[:employee_id])

      unless @employee
        raise V1::ErrorResponderService.new(:record_not_found, 404, ['Employee does not exist'])
      end

      @employee
    end

    def latest_evaluation
      @latest_evaluation ||= employee.latest_evaluation

      unless @latest_evaluation
        raise V1::ErrorResponderService.new(:record_not_found, 404, ['Employee was no evaluated yet'])
      end

      @latest_evaluation
    end

    def template
      @template ||= Template.find_by(id: @params[:template_id])

      unless @template
        raise V1::ErrorResponderService.new(:record_not_found, 404, ['Template does not exist'])
      end

      @template
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
