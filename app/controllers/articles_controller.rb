class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:update, :edit, :show, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:alert] = "Article has not been created"
      render :new
    end
  end

  def edit
    unless @article.user == current_user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    end
  end

  def update
    if @article.user != current_user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    elsif @article.update(article_params)
        flash[:success] = "Article has been updated"
        redirect_to @article
    else
        flash.now[:alert] = "Article has not been updated"
        render :edit
    end
  end
  
  def destroy
    if @article.user != current_user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    elsif @article.destroy
        flash[:success] = "Article has been deleted."
        redirect_to articles_path
    end
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end

  private
    def article_params
      params.require(:article).permit(:body, :title)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def resource_not_found
      message = "The article you are looking for could not be found" 
      flash[:alert] = message
      redirect_to root_path
    end

end
