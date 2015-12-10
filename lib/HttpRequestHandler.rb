require_relative 'HttpRequestParser'
require_relative 'Dispatcher'
require_relative 'Models/HttpResponse'

class HttpRequestHandler
  attr_reader :httpRequest, :httpResponse 
  def initialize(request)
    parser = HttpRequestParser.new
    @httpRequest = parser.parse(request)
  end

  def processRequest
    @dispatcher  = Dispatcher.new
    response = @dispatcher.process(@httpRequest)
    if response.nil?
      response = @dispatcher.responseNotFound
      @httpResponse = HttpResponse.new(@httpRequest, 404, response)
    else
      @httpResponse = HttpResponse.new(@httpRequest,200, response)
    end
  end
end
