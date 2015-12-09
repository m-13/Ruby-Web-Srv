require_relative 'Router'

class Dispatcher
  #controller and action are controller object and method objects here
  attr_accessor :controller , :action
  def process(httpRequest)
    #Create new Router
    router = Router.new
    # (string)controller and (string)action are fetched by the Router obj
    (controller , action , params) = router.get(httpRequest.method ,httpRequest.uri)
    if controller.nil?
      response = nil
    else
      require_relative controller
      @controller = Object.const_get(controller).new
      @action = @controller.method(action)
      response = @action.call(params)
    end
    return response
  end
end
