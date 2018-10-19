module V1
  class EvaluationSerializer
    include FastJsonapi::ObjectSerializer

    attributes :employee_id, :state, :completed_at

    attribute :sections_attributes do |template|
      template.sections.map{ |section| section.attributes.slice('id', 'name', 'group', 'width', 'position', 'skills') }
    end

  end
end