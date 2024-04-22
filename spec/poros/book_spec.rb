require 'rails_helper'

RSpec.describe Book do
  describe "initialize" do
    it "exists and populates attributes correctly" do
      title = "Denver, Co"
      isbn = ["0762507845", "9780762507849"]
      publi = ["Universal Map Enterprises"]
      data = {
        title: title, 
        isbn: isbn,
        publisher_facet: publi
      }
      book = Book.new(data)

      expect(book).to be_a(Book)
      expect(book.isbn).to eq(isbn)
      expect(book.publisher).to eq(publi)
    end
  end
end