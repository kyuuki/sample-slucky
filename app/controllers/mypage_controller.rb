class MypageController < ApplicationController
  before_action :authenticate_registrated_user!

  def index
    @user = current_user
  end
end
