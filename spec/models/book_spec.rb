require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:isbn) }
    it { should validate_presence_of(:publisher) }
  end

  # describe "initialize" do
  #   it "exists" do
  #     title = "Denver, Co Vicinity (City Wall Maps)"
  #     isbn = ["0762538627", "9780762538621"]
  #     publisher = ["Universal Map Enterprises"]
  #     book_data = {
  #       title: title,
  #       isbn: isbn,
  #       publisher: publisher,
  #     }
  #     book = Book.new(book_data)
      
  #     expect(book).to be_a(Book)
  #   end
  # end
end
