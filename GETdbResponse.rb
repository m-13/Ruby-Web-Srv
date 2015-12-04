require_relative 'HttpResponse'
require_relative 'OrderController'

class GETdbResponse < HttpResponse
  attr_accessor :controller
  def initialize(httpRequest)
    super(httpRequest)
    responseString = parseRequest
    # print "#{responseString}\n"
  end

  def parseRequest
    if (/\/order\/[0-9]+/ =~ httpRequest.requestURI) == 0
      (a, id) = httpRequest.requestURI.split("/order/")
      controller  = OrderController.new

      responseBody = controller.viewOrder(id)
      responseHeaders = ""
      statusLine = httpRequest.requestVersion+" "+"200"+" "+"Ok\n"
    else
      responseBody = "Weirdness"
      responseHeaders = ""
      statusLine = httpRequest.requestVersion+" 501 Not Implemented\n"
    end

    return statusLine+responseHeaders+"\r\n\r\n"+responseBody
  end

end
