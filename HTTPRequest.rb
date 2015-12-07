require_relative 'GETdbResponse'

class HTTPRequest
	attr_reader :requestString , :requestMethod , :requestURI , :requestVersion , :requestHeaders, :requestBody , :response
	def initialize(request)
		@requestString = request
		header, @requestBody = requestString.split("\r\n",2) unless requestString.empty?
		# puts "#{header}"
		# puts "#{requestBody}"
		requestLine, @requestHeaders = header.split("\n",2) unless header.empty?
		@requestMethod, @requestURI , @requestVersion = requestLine.split(" ",3) unless requestLine.empty?
	end

	def process
   return GETdbResponse.new(self)
	end

end
