class StaticPageController < ApplicationController
  before_action :authenticate_registrated_user!
  before_action :authenticate_paid_user!

  def root
    # render :root  # これが省略されている
  end
end
