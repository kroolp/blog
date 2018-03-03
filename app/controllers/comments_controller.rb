class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'secret', only: [:destroy]
  before_action :provide_article, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params.merge(article: @article))
    if @comment.save
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy!

    redirect_to article_path(@article)
  end

  private

  def provide_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
