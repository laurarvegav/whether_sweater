class BusinessFacade
  def self.find_munchie(params)
    data = BusinessService.search(params)

    Munchie.new(data[:businesses][0])
  end
end