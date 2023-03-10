class Admin::ArticlesController < Admin::ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_articles_url, notice: "保存しました。"
    else
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to admin_articles_url, notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_url, notice: "削除しました。"
  end

  private
    def article_params
      params.require(:article).permit(:service_id, :title, :video_tag, :content, :year, :month)
    end
end
