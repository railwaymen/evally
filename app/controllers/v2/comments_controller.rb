# frozen_string_literal: true

module V2
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!, except: :create

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

    private

    def authorize!
      authorize [:v2, comment]
    end

    def comment
      @comment ||= Comment.includes(:user).find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @comment

      @comment
    end

    def recruit
      @recruit ||= Recruit.find_by(human_resources_id: params[:recruit_id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @recruit

      @recruit
    end

    def create_form
      @create_form ||= V2::Comments::BasicForm.new(
        recruit.comments.build(user_id: current_user.id),
        params: comment_params
      )
    end

    def update_form
      @update_form ||= V2::Comments::BasicForm.new(
        comment,
        params: comment_params
      )
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
  end
end
