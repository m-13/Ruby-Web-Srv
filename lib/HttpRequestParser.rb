require_relative 'Models/HttpRequest'

class HttpRequestParser
  def parse(request)
    requestString = request
		header, requestBody = requestString.split("\r\n\r\n",2) unless requestString.empty?
		requestLine, requestHeaders = header.split("\r\n",2) unless header.empty?
		requestMethod, requestURI , requestVersion = requestLine.split(" ",3) unless requestLine.empty?
    param = {:request => request, :method => requestMethod , :uri => requestURI , :version => requestVersion , :headers => requestHeaders , :body => requestBody }
    return HttpRequest.new(param)
  end
end
