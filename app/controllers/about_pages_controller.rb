class AboutPagesController < ApplicationController
  validates :content, presence: true
  def show
    @about_page = AboutPage.first
end