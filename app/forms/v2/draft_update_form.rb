# frozen_string_literal: true

module V2
  class DraftUpdateForm
    attr_reader :draft

    def initialize(draft, params:, user:)
      @draft = draft
      @params = params
      @user = user

      @draft.assign_attributes(
        state: resolve_state,
        completed_at: resolve_completed_at,
        sections_attributes: params[:sections]
      )
    end

    def save
      validate_draft!

      ActiveRecord::Base.transaction do
        create_activity! if @draft.changed?
        save_next_evaluation_date! if @draft.completed?

        @draft.save!
      end
    end

    private

    def validate_draft!
      return if @draft.valid?

      raise ErrorResponderService.new(:invalid_record, 422, @draft.errors.full_messages)
    end

    def create_activity!
      @user.activities.create!(
        action: resolve_action,
        activable: @draft,
        activable_name: employee.fullname
      )
    end

    def employee
      @employee ||= @draft.employee
    end

    def resolve_action
      @draft.completed? ? :complete : :update
    end

    def resolve_completed_at
      @params[:state] == 'completed' ? Time.now.utc : nil
    end

    def resolve_state
      @params[:state] == 'completed' ? :completed : :draft
    end

    def save_next_evaluation_date!
      employee.update!(next_evaluation_on: @params[:next_evaluation_on])
    end
  end
end
