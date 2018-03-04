class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'secret', except: [:index, :show]

  before_action :provide_article, only: [:show, :destroy, :edit, :update]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new(commenter: session[:commenter])
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def provide_article
    @article = Article.find(params[:id])
  end
end
