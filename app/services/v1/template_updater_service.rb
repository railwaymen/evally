module V1
  class TemplateUpdaterService

    def initialize(attributes:, template:)
      @attributes = attributes
      @template = template
    end

    def call
      @form.model if update_template && notify
    end

    private

    def update_template
      @form = V1::TemplateForm.new(@template, filtered_attributes)

      unless @form.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @form.errors.messages)
      end

      @form.submit!
    end

    def filtered_attributes
      @attributes.permit(:name, :state, sections_attributes: [:id, :name, :group, :width, :position, :_destroy, skills: [:name, :value]])
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

  end
end
