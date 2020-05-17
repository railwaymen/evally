# frozen_string_literal: true

module V2
  module Recruits
    class Serializer < Blueprinter::Base
      identifier :id

      fields :public_recruit_id

      field :evaluator_fullname do |employee|
        employee.evaluator&.fullname
      end

      view :search do
        fields :evaluation_id, :evaluation_date

        field :skill do |recruit|
          {
            group: recruit.attributes['skill_group']
          }.merge(recruit.attributes.fetch('skill', {}))
        end
      end
    end
  end
end
