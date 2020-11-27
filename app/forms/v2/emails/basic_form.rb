# frozen_string_literal: true

module V2
  module Emails
    class BasicForm
      include ActiveModel::Validations
      include EmailValidatable

      delegate :from, :to, :cc, :bcc, :subject, :body, :recruit_document_id, to: :@email

      validates :from, :to, :subject, :body, :recruit_document_id, presence: true

      validates :from, :to, email: true
      validates :cc, :bcc, email: true, allow_blank: true

      def initialize(recruit, user:, params: {})
        @recruit = recruit

        @email = OpenStruct.new(params)
        @user = user
      end

      def save
        validate_email!

        RecruitmentMailer
          .with(user: @user, email: @email)
          .custom_email
          .deliver_now

        comment.save
      end

      private

      def validate_email!
        return if valid?

        raise ErrorResponderService.new(:invalid_record, 422, errors.full_messages)
      end

      def comment
        @comment ||= @recruit.comments.build(
          body: @email.body,
          user: @user,
          recruit_document_id: @email.recruit_document_id,
          created_by: 'mailer'
        )
      end
    end
  end
end
