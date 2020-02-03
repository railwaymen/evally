# frozen_string_literal: true

module V2
  class ProfilePresenter
    attr_reader :user

    delegate :setting, to: :user

    def initialize(user)
      @user = user
    end
  end
end
