class ArticlesController < ApplicationController
  before_action :provide_article, only: [:show, :destroy, :edit, :update, :add_like]

  def index
    if params[:q].present?
      @articles = Article.where("? = any(tags)", params[:q])
    else
      @articles = Article.all
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_path(@article), notice: 'Pomyślnie utworzono artykuł'
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new(commenter: session[:commenter])
    @user_like = @article.likes.find_by(user: current_user)
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

  def add_like
    @article.likes.create(user: current_user)

    redirect_to article_path(@article)
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :tags, :image)
          .merge(user: current_user)
  end

  def provide_article
    @article = Article.find(params[:id])
  end
end
