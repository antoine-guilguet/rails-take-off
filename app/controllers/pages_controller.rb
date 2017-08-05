class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: :homepage

  def homepage
    render layout: 'homepage'
  end
end
