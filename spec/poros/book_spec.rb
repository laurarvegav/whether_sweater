require 'rails_helper'

RSpec.describe Book do
  describe "#initialize" do
    it "exists and populates attributes correctly" do
      title = "example"
      isbn = ["125", "123"]
      publisher = ["turing"]
      data = { 
        title: title,
        isbn: isbn,
        publisher: publisher
      }
      book = Book.new(data)
      
      expect(book).to be_a(Book)
      expect(book.title).to eq(title)
      expect(book.isbn).to eq(isbn)
      expect(book.publisher).to eq(publisher)
    end
  end
end
