module V1
  class UserCreatorService

    def initialize(attributes:)
      @attributes = attributes
    end

    def call
      @model if can_create_user? && create_new_user
    end

    private

    def can_create_user?
      # TODO: (FF) set some app password to create new accounts
      true
    end

    def create_new_user
      @model = User.new(user_params)

      unless @model.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @model.errors.full_messages)
      end

      @model.save!
    end

    def user_params
      @attributes.permit(:email, :password, :first_name, :last_name)
    end

  end
end
