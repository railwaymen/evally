module V1
  class TemplateUpdaterService

    def initialize(attributes:, template:)
      @attributes = attributes
      @template = template
    end

    def call
      @template if update_template && notify
    end

    private

    def update_template
      @template.attributes = template_params

      unless @template.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @template.errors.full_messages)
      end

      @template.save!
    end

    def template_params
      @attributes.permit(:name, :state, sections_attributes: [:id, :name, :group, :width, :position, :_destroy, skills: [:name, :value]])
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

  end
end
