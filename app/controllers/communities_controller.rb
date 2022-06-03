class CommunitiesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  def index
    @communities = Communities.all
  end

  def new
    @community = Communities.new
  end
end
