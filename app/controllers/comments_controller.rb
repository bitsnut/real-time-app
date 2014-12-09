class CommentsController < ApplicationController
  before_action :set_comments, only: [:edit, :destroy]
  before_filter :authenticate_user!, except: [:index]

  def index
    @comments = Comment.all.order('created_at DESC')
    respond_to do |format|
      format.html {  }
      format.json { render json: @comments }
    end
  end

  def new

    parent = Comment.find(params[:parent_id])
    @obj = parent.commentable_type.constantize.find(parent.commentable_id)

    if signed_in?
      @child_comment = parent.children.build_from(@obj, current_user.id, "")
      @comment = Comment.build_from(@obj, current_user.id, "")
    end

    logger.debug "asdfasdfsadf"

  end

  def create

    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment][:parent_id])

      @obj = parent.commentable_type.constantize.find(parent.commentable_id)
      @comment = parent.children.build_from(@obj, current_user.id, params[:comment][:body])
      @comment.parent_id = params[:comment][:parent_id]
      logger.debug "@comment: #{@comment.inspect}"
    else
      @comment = Comment.build_from(Post.find(params[:post_id]), current_user.id, params[:comment][:body])
    end


    respond_to do |format|
      if @comment.save
        format.html {
          # No need to redirect to the comment where the user wrote because of using real-time comment
          # redirect_to "/posts/#{@comment.obj.id}#comment_#{@comment.id}"
        }
        format.json { render json: @comment, status: :created }
        format.js
      else
        format.html { go_back }
        format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
        format.js
      end
    end

  end

  def edit
    # authorize @comment, :edit?
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.js
    end
  end

  def update

    @comment = Comment.find(params[:id])
    @comment.body = params[:comment][:body]

    # authorize @comment, :update?
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { go_back }
        format.json { render json: @comment }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    # authorize @comment, :destroy?
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to "/posts/#{@comment.obj.id}#comment_#{@comment.id}" }
      format.json { head :no_content }
      format.js
    end
  end

  private
  def set_comments
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :title, :subject, :parent_id, :lft, :rgt)
  end

end