class StaticPageController < ApplicationController
  # TODO: 順序要確認
  before_action :authenticate_registrated_user!
  before_action :authenticate_paid_user!

  def root
    @articles = Article.where(service: Service.main)
    # render :root  # これが省略されている
  end

  def under
  end
end
