class Api::V1::BooksController < ApplicationController
  def search
    service = ServicesFacade.find_books(book_params)
    render json: BookSerializer.new(service)
  end

  private
  def book_params
    params.permit(:location, :quantity)
  end
end