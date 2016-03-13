class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  layout "home_layout"
  def home
  end
end
