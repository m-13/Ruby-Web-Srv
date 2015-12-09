require_relative 'HttpRequestParser'
require_relative 'Dispatcher'
require_relative 'HttpResponse'

class HttpRequestHandler
  attr_accessor :httpRequest, :httpResponse , :dispatcher
  def initialize(request)
    parser = HttpRequestParser.new
    @httpRequest = parser.parse(request)
  end

  def processRequest
    @dispatcher  = Dispatcher.new
    response = @dispatcher.process(@httpRequest)
    if response.nil?
      @httpResponse = HttpResponse.new(@httpRequest, 404)
    else
      @httpResponse = HttpResponse.new(@httpRequest,200, response)
      puts "HttpResponse Created"
    end
  end
end
