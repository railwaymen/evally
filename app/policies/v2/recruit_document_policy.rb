# frozen_string_literal: true

module V2
  class RecruitDocumentPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.admin? || user.recruiter?
    end

    def new?
      create?
    end

    def update?
      user.admin? || user.recruiter?
    end

    def edit?
      update?
    end
  end
end
