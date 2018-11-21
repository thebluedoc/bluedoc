# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_anonymous!
  before_action :set_comment, only: [:show, :edit, :reply, :in_reply, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :reply, :edit, :update, :destroy]

  def show
  end

  def reply
  end

  def in_reply
  end

  def create
    klass = comment_params[:commentable_type].constantize
    commentable = klass.find(comment_params[:commentable_id])

    authorize! :read, commentable

    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  # PATCH/PUT /comments/1
  def update
    authorize! :update, @comment

    @success = @comment.update(body: comment_params[:body])
  end

  # DELETE /comments/1
  def destroy
    authorize! :destroy, @comment

    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:commentable_type, :commentable_id, :parent_id, :body)
    end
end