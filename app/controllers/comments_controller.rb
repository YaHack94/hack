class CommentsController < ApplicationController
  before_action :set_publication, only: [:create, :edit, :update]
  def create
    @comments = Comment.where(publication_id: @publication)
    @comment = @publication.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to publication_path(@publication) }
        format.js { render :index }
      else
        format.html { redirect_to publication_path(@publication), notice: "Couldn't post..." }
        format.js { redirect_to publication_path(@publication), notice: "Couldn't post..." }
      end
    end
  end
  def edit
    @comment = @publication.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'Editing comment'
      format.js { render :edit }
    end
  end
  def update
    @comment = @publication.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.js { render :index }
      else
        format.js { render :edit_error }
      end
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @publication.order("created_at DESC")
    @comment.destroy
    respond_to do |format|
      #flash.now[:notice] = 'Comment deleted'
      format.html { redirect_to publication_path(@publication)}
      format.js { render :index }
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:user_id, :publication_id, :content)
    end
    def set_publication
      @publication = Publication.find(params[:publication_id])
    end
end