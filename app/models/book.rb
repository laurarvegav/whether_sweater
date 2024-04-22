class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :isbn
  validates_presence_of :publisher

  def initialize(data)
    @title = data[:title]
    @isbn = data[:isbn]
    @publisher = data[:publisher]
  end
end
