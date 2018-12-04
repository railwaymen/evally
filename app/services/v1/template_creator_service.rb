module V1
  class TemplateCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @template if create_new_template && add_activity
    end

    private

    def create_new_template
      @template = @user.templates.build(template_params)

      unless @template.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @template.errors.full_messages)
      end

      @template.save!
    end

    def template_params
      @attributes.permit(:name, :state, sections_attributes: [:name, :group, :width, :position, skills: [:name, :value, :needToImprove]])
    end

    def add_activity
      @user.activities.create!(action: 'create', activable: @template, activable_name: @template.name)
    end
  end
end
