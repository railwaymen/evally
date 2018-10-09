module V1
  class TemplateForm < ApplicationForm

    FIELDS = ['name', 'state', 'sections_attributes'].freeze
    attr_accessor *FIELDS

    validates :name, presence: true

    validates :state, presence: true, inclusion: { in: Template.states.keys }

    validates :sections_attributes, presence: true, allow_blank: true

  end
end