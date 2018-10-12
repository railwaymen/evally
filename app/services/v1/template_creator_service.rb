module V1
  class TemplateCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @form.model if create_new_template && notify
    end

    private

    def create_new_template
      @form = V1::TemplateForm.new(@user.templates.build, filtered_attributes)

      unless @form.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @form.errors.messages)
      end

      @form.submit!
    end

    def filtered_attributes
      @attributes.permit(:name, :state, sections_attributes: [:name, :group, :width, :position, :_destroy, skills: [:name, :value]])
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

  end
end
