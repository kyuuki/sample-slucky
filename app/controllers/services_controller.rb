class ServicesController < ApplicationController
  # TODO: 順序要確認
  before_action :authenticate_registrated_user!
  before_action :authenticate_paid_user!

  def show
    service = Service.find(params[:id])
    @articles = Article.where(service: service)
  end
end
