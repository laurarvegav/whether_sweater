class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :isbn
  validates_presence_of :publisher
end
