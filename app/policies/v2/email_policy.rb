# frozen_string_literal: true

module V2
  EmailPolicy = Struct.new(:user, :email) do
    def form?
      %w[admin recruiter].include?(user&.role)
    end

    def create?
      form?
    end
  end
end
