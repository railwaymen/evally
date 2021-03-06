# frozen_string_literal: true

module V2
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_member!, except: %i[create webhook]

    def create
      create_form.save

      render json: V2::Comments::Serializer.render(create_form.comment), status: :created
    end

    def update
      update_form.save

      render json: V2::Comments::Serializer.render(update_form.comment), status: :ok
    end

    def destroy
      comment.update(discarded_at: Time.current)

      render json: V2::Comments::Serializer.render(comment), status: :ok
    end

    def webhook
      head webhook_form.save ? :no_content : :unprocessable_entity
    end

    private

    def authorize_member!
      authorize [:v2, comment]
    end

    def comment
      @comment ||= recruit.comments.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @comment

      @comment
    end

    def recruit
      @recruit ||= Recruit.find_by(public_recruit_id: params[:recruit_id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @recruit

      @recruit
    end

    def create_form
      @create_form ||= V2::Comments::BasicForm.new(
        recruit.comments.build(user_id: current_user.id),
        params: comment_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::Comments::BasicForm.new(
        comment,
        params: comment_params,
        user: current_user
      )
    end

    def webhook_form
      @webhook_form ||= V2::Comments::WebhookForm.new(
        recruit: recruit,
        params: webhook_params,
        user: current_user
      )
    end

    def comment_params
      params.require(:comment).permit(:body, :recruit_document_id)
    end

    def webhook_params
      params.require(:comment).permit(:body, :created_at, :change_id, :recruit_document_id)
    end
  end
end
