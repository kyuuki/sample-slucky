class StaticPageController < ApplicationController
  def root
    @articles = Article.where(service: Service.main)
    # render :root  # これが省略されている
  end

  def under
  end

  def copyright
  end

  def tokushoho
  end

  def privacy
  end

  def terms
  end
end
