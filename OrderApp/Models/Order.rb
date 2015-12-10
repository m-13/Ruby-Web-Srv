
class Order
  attr_accessor :id, :name, :price
  def initialize(id = nil, name = nil , price = nil)
    @id = id
    @name = name
    @price = price
  end
end
