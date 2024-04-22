FactoryBot.define do
  factory :book do
    title { "MyString" }
    isbn=array { "MyString" }
    publisher=array { "MyString" }
  end
end
