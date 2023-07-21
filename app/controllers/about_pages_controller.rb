class AboutPagesController < ApplicationController
  def show
    @about_page = AboutPage.first # Assuming there is only one about page, adjust this according to your data structure
  end
end