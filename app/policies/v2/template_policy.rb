# frozen_string_literal: true

module V2
  class TemplatePolicy < ApplicationPolicy
    def update?
      user.admin? || recruitable_template? || employable_template?
    end

    def destroy?
      update?
    end

    private

    def recruitable_template?
      user.recruiter? && record.for_recruits?
    end

    def employable_template?
      user.id == record.creator_id && record.for_employees?
    end
  end
end
