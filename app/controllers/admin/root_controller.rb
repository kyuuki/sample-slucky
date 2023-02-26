# top や home もあるがページの名前変わる可能性があるので root が一番よさげ
class Admin::RootController < Admin::ApplicationController
  def index
  end
end
