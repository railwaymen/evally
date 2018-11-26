module V1
  class PasswordUpdaterService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @user if user_authenticated? && update_password
    end

    private

    def user_authenticated?
      return true if @user.authenticate(password_params[:old_one])
      raise V1::ErrorResponderService.new(:invalid_record, 422, ['Invalid password'])
    end

    def update_password
      @user.password = password_params[:new_one]

      unless @user.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
      end

      @user.save!
    end

    def password_params
      @attributes.permit(:old_one, :new_one)
    end

  end
end
