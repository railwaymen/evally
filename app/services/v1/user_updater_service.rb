module V1
  class UserUpdaterService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @user if update_user
    end

    private

    def update_user
      @user.attributes = user_params

      unless @user.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
      end

      @user.save!
    end

    def user_params
      @attributes.permit(:first_name, :last_name)
    end

  end
end
