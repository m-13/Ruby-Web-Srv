require_relative 'HttpResponse'
require_relative 'OrderController'

class GETdbResponse < HttpResponse
  attr_accessor :controller
  def initialize(httpRequest)
    super(httpRequest)
    @responseString = parseRequest
    # print "#{responseString}"
  end

  def parseRequest
    @controller  = OrderController.new
    if (/\/order\/[0-9]+/ =~ httpRequest.requestURI) == 0
      (a, id) = httpRequest.requestURI.split("/order/")
      @responseBody = controller.viewOrder(id)
      @responseHeaders = ""
      @statusLine = httpRequest.requestVersion+" "+"200"+" "+"Ok\n"
    elsif (/\/orders\?/ =~ httpRequest.requestURI) == 0
      (url , params) = httpRequest.requestURI.split(/\?/)
      # puts "#{url}:#{params}"
      p_hash = Hash.new
      # puts "#{p_hash.empty?}"
      unless params.nil?
        p = params.split("&")
        p.each do |element|
          e = element.split("=")
          p_hash[e[0]] = e[1]
        end
      end
      @responseBody = controller.viewOrders(p_hash)
      @responseHeaders = ""
      @statusLine = httpRequest.requestVersion+" "+"200"+" "+"Ok\n"
    else
      @responseBody = "favicon"
      @responseHeaders = ""
      @statusLine = httpRequest.requestVersion+" 501 Not Implemented\n"
    end
    return statusLine+responseHeaders+"\r\n"+responseBody
  end

end
