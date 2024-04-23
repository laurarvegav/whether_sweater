class Api::V1::BooksController < ApplicationController
  def search
    service = BoookFacade.find_books(book_params)

    output = {
      data: {
        id: nil,
        type: "books",
        attributes: service
      }
    }
 
    render json: output, status: :ok
  end

  private
  def book_params
    params.permit(:location, :quantity)
  end
end