class Munchie
  attr_reader :name,
              :address, 
              :raiting,
              :reviews

  def initialize(data)
    @name = data[:name]
    @address = data[:location][:display_address].join(", ")
    @raiting = data[:raiting]
    @reviews = data[:review_count]
  end
end