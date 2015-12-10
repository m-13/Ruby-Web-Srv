require_relative 'Route'

# route_name = Route.new(pattern, app_name, controller_name, action_name, params_from_regex)
#default route when no url is given
index = Route.new(//,"","IndexController", "Index",nil )

vierOrder = Route.new(/(\/order\/)(?<id>[0-9]+)/, "/Order" , "OrderController", "viewOrder" , "#{$id}" )
viewOrders = Route.new(/(\/orders)(\?+)(?<params>.*)/, "/Order" , "OrderController", "viewOrders", "#{$params}")

routes = [index, viewOrders, viewOrder]
