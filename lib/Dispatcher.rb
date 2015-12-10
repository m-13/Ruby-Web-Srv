require_relative 'Router'
require 'erb'

class Dispatcher
  def process(httpRequest)
    #Create new Router
    router = Router.new
    #router checks method and url, matches it to a pattern
    #and sends the corresponding controller, action, and parameters for url
    #returns nil if no pattern is found.
    (app, controller , action , params) = router.get(httpRequest.method ,httpRequest.uri)
    # When router can't find a match
    if controller.nil?
      response = nil
    # invoke controller.method(params)
    else
      require_relative "../#{app}/Controllers/#{controller}"
      @controller = Object.const_get(controller).new
      @action = @controller.method(action)
      @action.call(params)

      template = ERB.new File.read("#{app}/Views/#{action}.html.erb")
      response = template.result(@controller.get_bindings)
    end
    return response
  end
  def responseNotFound
    template = ERB.new File.read("lib/Views/404.html.erb")
    response = template.result
  end
end
