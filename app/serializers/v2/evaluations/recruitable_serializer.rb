# frozen_string_literal: true

module V2
  module Evaluations
    class RecruitableSerializer < Blueprinter::Base
      identifier :id

      fields :recruit_id, :state, :template_name, :updated_at, :completed_at
    end
  end
end
