module V1
  class TemplateCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @model if create_new_template && notify
    end

    private

    def create_new_template
      @model = @user.templates.build(template_params)

      unless @model.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @model.errors.messages)
      end

      @model.save!
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

    def template_params
      @attributes.permit(:name, :state, sections_attributes: [:name, :group, :width, :position, skills: [:name, :value]])
    end
  end
end
