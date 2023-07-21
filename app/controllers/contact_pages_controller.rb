class ContactPagesController < ApplicationController
  def show
    @contact_page = ContactPage.first # Assuming there is only one contact page, adjust this according to your data structure
  end
end