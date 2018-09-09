module V1
  class UserCreatorService

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      @form.model if can_create_user? && create_new_user
    end

    private

    def can_create_user?
      # TODO: (FF) set some app password to create new accounts
      true
    end

    def create_new_user
      @form = V1::UserCreateForm.new(User.new)

      unless @form.validate(@attributes)
        raise V1::ErrorResponderService.new(:invalid_record, 422, @form.errors.messages)
      end

      @form.save
    end

  end
end
