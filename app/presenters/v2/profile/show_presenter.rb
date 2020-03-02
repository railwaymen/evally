# frozen_string_literal: true

module V2
  module Profile
    class ShowPresenter
      attr_reader :user

      delegate :setting, to: :user

      def initialize(user)
        @user = user
      end
    end
  end
end
