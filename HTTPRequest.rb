require_relative 'HttpResponse'


class HTTPRequest
	attr_reader :requestString , :requestMethod , :requestURI , :requestVersion , :requestHeaders, :requestBody
	def initialize(request)
		@requestString = request
		
		header, @requestBody = requestString.split("\r\n",2) unless requestString.empty?

		requestLine, @requestHeaders = header.split("\n",2) unless header.empty?

		@requestMethod, @requestURI , @requestVersion = requestLine.split(" ",3) unless requestLine.empty?

	end

	def process
	 return HttpResponse.new(self)
	end




end

