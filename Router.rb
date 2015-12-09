
class Router
  def get(method, url)
    case url
    when /(\/order\/)([0-9]+)/
      return "OrderController", "viewOrder", "#{$2}"
    when /(\/orders)(\?+)(.*)/
      return "OrderController" , "viewOrders", "#{$3}"
    else
      return nil
    end
  end
end
